class OrderController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :notification
  protect_from_forgery
 
  # Gerar um Token de sessão para nosso pagamento
  def new
    @product = Post.find(params[:product_id])
    @session_id = (PagSeguro::Session.create).id

    material = Printer.last.materials[0]
	volume = @product.volume / 1000
	@preco = (material.preco*volume).round(2)
	PagMailer.print_email(User.last).deliver
  end
 
  # Enviar nosso pagamento para o Pagseguro
  def create
    @product = Post.find(params[:product_id])
    material = Printer.last.materials[0]
	volume = @product.volume / 1000
	@preco = (material.preco*volume).round(2)

 
    payment = PagSeguro::CreditCardTransactionRequest.new
    payment.notification_url = "https://secret-wave-53573.herokuapp.com/notification  "
    payment.payment_mode = "default"
 
    # Aqui vão os itens que serão cobrados na transação, caso você tenha multiplos itens
    # em um carrinho altere aqui para incluir sua lista de itens
    payment.items << {
      id: @product.id,
      description: @product.caption,
      amount: 1,
      weight: 0
    }
 
    # Criando uma referencia para a nossa ORDER
    reference = "REF_#{(0...8).map { (65 + rand(26)).chr }.join}_#{@product.id}"
    payment.reference = reference
    payment.sender = {
      hash: params[:sender_hash],
      name: params[:name],
      email: params[:email],
      cpf: params[:cpf],
      phone: {
       area_code: params[:phone_code],
       number: params[:phone_number]
     }
    }
  payment.shipping = {
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
  payment.billing_address = {
    street: params[:street],
    number: params[:number],
    complement: params[:complement],
    district: params[:district],
    city: params[:city],
    state: params[:state],
    postal_code: params[:postal_code]

}
 
    payment.credit_card_token = params[:card_token]
    payment.holder = {
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
 
    #payment.installment = {
     #value: "3,05",
     #quantity: params[:parcelamento]
    #}
 
    puts "=> REQUEST"
    puts PagSeguro::TransactionRequest::RequestSerializer.new(payment).to_params
    puts
 
    payment.create
 
    # Cria uma Order para registro das transações
    Order.create(product_id: @product.id, buyer_name: params[:name], reference: reference, status: 'pending')
 
    if payment.errors.any?
     puts "=> ERRORS"
     puts payment.errors.join("\n")
     render plain: "Erro No Pagamento #{payment.errors.join("\n")}"
    else
     puts "=> Transaction"
     puts "  code: #{payment.code}"
     puts "  reference: #{payment.reference}"
     puts "  type: #{payment.type_id}"
     puts "  payment link: #{payment.payment_link}"
     puts "  status: #{payment.status}"
     puts "  payment method type: #{payment.payment_method}"
     puts "  created at: #{payment.created_at}"
     puts "  updated at: #{payment.updated_at}"
     puts "  gross amount: #{payment.gross_amount.to_f}"
     puts "  discount amount: #{payment.discount_amount.to_f}"
     puts "  net amount: #{payment.net_amount.to_f}"
     puts "  extra amount: #{payment.extra_amount.to_f}"
     puts "  installment count: #{payment.installment_count}"
 
     puts "    => Items"
     puts "      items count: #{payment.items.size}"
     payment.items.each do |item|
       puts "      item id: #{item.id}"
       puts "      description: #{item.description}"
       puts "      quantity: #{item.quantity}"
       puts "      amount: #{item.amount.to_f}"
     end
 
     puts "    => Sender"
     puts "      name: #{payment.sender.name}"
     puts "      email: #{payment.sender.email}"
     puts "      phone: (#{payment.sender.phone.area_code}) #{payment.sender.phone.number}"
     puts "      document: #{payment.sender.document}: #{payment.sender.document}"
     render plain: "Sucesso, seu pagamento será processado :)"
    end
 
  end
  def notification
    transaction = PagSeguro::Transaction.find_by_notification_code(params[:notificationCode])
    status = ['Aguardando Pagamento', 'Em análise', 'Paga', 'Disponível', 'Em disputa', 'Devolvida', 'Cancelada']
 
    if transaction.errors.empty?
      order = Order.where(reference: transaction.reference).last
      order.status = status[transaction.status.id.to_i - 1]
      order.save
    end
 
      render nothing: true, status: 200
  end
  def index
    @orders = Order.all
  end
end