class OrderController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :notification
  #protect_from_forgery with: :exception
 skip_before_action :verify_authenticity_token

  # Gerar um Token de sessão para nosso pagamento
  def new
    @printer = Printer.last
    @user = User.find_by(user_name: params[:user_name])
    @carrinho = @user.carrinhos.find_by(:status => 'criado')

    @session_id = (PagSeguro::Session.create).id
    @preco = 0
    @carrinho.orders.each do |order|
      order.quantidade.times do
        @preco = @preco + order.price
      end
    end
    @preco = '%.2f' % @preco.round(2)
	  #PagMailer.print_email(current_user).deliver
  end
 
  # Enviar nosso pagamento para o Pagseguro
  def create
    @user = User.find_by(user_name: params[:user_name])
    @carrinho = @user.carrinhos.find_by(:status => 'criado')

 
    @payment = PagSeguro::CreditCardTransactionRequest.new
    @payment.notification_url = "https://beeprinted.herokuapp.com/order/notification"
    @payment.payment_mode = "default"
 
    # Aqui vão os itens que serão cobrados na transação, caso você tenha multiplos itens
    # em um carrinho altere aqui para incluir sua lista de itens
    @preco = 0
    @carrinho.orders.each do |order|
      order.quantidade.times do
        @preco = @preco + order.price
        @payment.items << {
          id: order.id,
          description: order.post.caption,
          amount: order.price,
          weight: 0
        }
      end
    end
 
    # Criando uma referencia para a nossa ORDER
    reference = "REF_#{(0...8).map { (65 + rand(26)).chr }.join}_#{@carrinho.id}"
    @payment.reference = reference
    @payment.sender = {
      hash: params[:sender_hash],
      name: params[:name],
      email: params[:email],
      cpf: params[:cpf],
      phone: {
       area_code: params[:phone_code],
       number: params[:phone_number]
     }
    }
  @payment.shipping = {
  type_name: "sedex",
  cost: 0,
  address: {
    street: params[:street],
    number: params[:number],
    complement: params[:complement],
    district: params[:district],
    city: params[:city],
    state: params[:state],
    postal_code: params[:postal_code]
  }

}
  @payment.billing_address = {
    street: params[:street],
    number: params[:number],
    complement: params[:complement],
    district: params[:district],
    city: params[:city],
    state: params[:state],
    postal_code: params[:postal_code]

}
 
    @payment.credit_card_token = params[:card_token]
    @payment.holder = {
     name: params[:card_name],
     birth_date: params[:birthday],
     document: {
       type: "CPF",
       value: params[:cpf]
     },
     phone: {
       area_code: params[:phone_code],
       number: params[:phone_number]
     }
    }
 
    @payment.installment = {
     value: params[:parcela],
     quantity: params[:quantidade]
    }
 
    puts "=> REQUEST"
    puts PagSeguro::TransactionRequest::RequestSerializer.new(@payment).to_params
    puts
 
    @payment.create
 
    # Cria uma Order para registro das transações
    #PagMailer.print_email(@order).deliver
    if @payment.errors.any?
     puts "=> ERRORS"
     puts @payment.errors.join("\n")
     #render plain: "Erro No Pagamento #{payment.errors.join("\n")}"
     render 'order/error'
    else
      @carrinho = @carrinho.update_attributes(:buyer_name => params[:name],
      :email => params[:email],
      :cpf => params[:cpf],
      :reference => reference,
      :status => 'pending', 
      :price => @preco,
      :street => params[:street],
      :number => params[:number],
      :complement => params[:complement],
      :district => params[:district],
      :city => params[:city],
      :state => params[:state],
      :postal_code => params[:postal_code]
    )
     puts "=> Transaction"
     puts "  code: #{@payment.code}"
     puts "  reference: #{@payment.reference}"
     puts "  type: #{@payment.type_id}"
     puts "  payment link: #{@payment.payment_link}"
     puts "  status: #{@payment.status}"
     puts "  payment method type: #{@payment.payment_method}"
     puts "  created at: #{@payment.created_at}"
     puts "  updated at: #{@payment.updated_at}"
     puts "  gross amount: #{@payment.gross_amount.to_f}"
     puts "  discount amount: #{@payment.discount_amount.to_f}"
     puts "  net amount: #{@payment.net_amount.to_f}"
     puts "  extra amount: #{@payment.extra_amount.to_f}"
     puts "  installment count: #{@payment.installment_count}"
 
     puts "    => Items"
     puts "      items count: #{@payment.items.size}"
     @payment.items.each do |item|
       puts "      item id: #{item.id}"
       puts "      description: #{item.description}"
       puts "      quantity: #{item.quantity}"
       puts "      amount: #{item.amount.to_f}"
     end
 
     puts "    => Sender"
     puts "      name: #{@payment.sender.name}"
     puts "      email: #{@payment.sender.email}"
     puts "      phone: (#{@payment.sender.phone.area_code}) #{@payment.sender.phone.number}"
     puts "      document: #{@payment.sender.document}: #{@payment.sender.document}"
     #render plain: "Sucesso, seu pagamento será processado :)"
     render 'order/sucesso'
    end
 
  end
  def destroy
    @order = Order.find(params[:id])
    if @order.user.id == current_user.id
      @order.delete
      @preco = 0
      @order.carrinho.orders.each do |order|
        order.quantidade.times do
          @preco = @preco + order.price
        end
      end
      @preco = '%.2f' % @preco.round(2)
      respond_to do |format|
        format.html {redirect_to carrinho_path(@order.carrinho.id)}
        format.js
      end
    end
  end
  def notification
    transaction = PagSeguro::Transaction.find_by_notification_code(params[:notificationCode])
    status = ['Aguardando Pagamento', 'Em análise', 'Pago', 'Disponível', 'Em disputa', 'Devolvido', 'Cancelado']
 
    if transaction.errors.empty?
      carrinho = Carrinho.where(reference: transaction.reference).last
      carrinho.status = status[transaction.status.id.to_i - 1]
      carrinho.save
      if transaction.status.id.to_i == 3
        PagMailer.print_email(carrinho).deliver

        carrinho.orders.each do |order|
          post = order.post
          prints = post.prints + 1
          post.update_attribute(:prints, prints)
        end
        
      end
      if transaction.status.id.to_i == 
      	carrinho.status = 'criado'
      	carrinho.save
      end
      create_notification(carrinho)
    end
 
      render nothing: true, status: 200
  end
  def index
    @carrinhos = Carrinho.all
  end
  private
  def create_notification(carrinho)  
    Notification.create(user_id: carrinho.user.id,
                        notified_by_id: User.first.id,
                        post_id: carrinho.id,
                        identifier: User.first.id,
                        notice_type: "Seu pagamento de R$#{carrinho.price} está #{carrinho.status}",
                        status: "pag_confirmation")
  end
end