class CkeckoutController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :checkouts
  layout false
  def new
    if current_user.carrinhos.where(:status => 'criado').any?
          carrinho = current_user.carrinhos.find_by(:status => 'criado')
      else
        carrinho = current_user.carrinhos.build(status: 'criado')
      end
      @post = Post.find(params[:id])
      @order = carrinho.orders.build
      @materials = Printer.last.materials.order(:name)
  end
  def create
    if current_user.carrinhos.where(:status => 'criado').any?
          carrinho = current_user.carrinhos.find_by(:status => 'criado')
      else
        carrinho = current_user.carrinhos.build(status: 'criado')
      end
      @order = carrinho.orders.build(order_params)

    post = Post.find(params[:id])
    post.volume = post.volume.round(0)
    material = Printer.last.materials.find_by(:name => @order.material)
    printer = Printer.last

    post.x = post.x/10
      post.y = post.y/10
      post.z = post.z/10

      shell = post.area*0.08
      percentShell = shell/(post.volume*@order.scale)
      if percentShell > 1
        percentShell = 1
      end
      #shell = shell + 0.8*@post.area*0.04
      preench = @order.preench.split("%")
      preench = preench.first.to_f/100
      scale = @order.scale*@order.scale*@order.scale
      peso = scale*post.volume*material.densidade*(percentShell + (1 - percentShell)*preench)
      precoMatDesg = peso*(material.preco + printer.desgaste*0.2/@order.resolution.to_f)
      precoEnerg = ((peso/(40*@order.resolution.to_f)) + 0.2)*material.potencia*printer.kwh
      if ((post.volume*scale >= 0) && (post.volume*scale < 30))
        lucro = 3 - (0.7/30)*post.volume*scale
      elsif ((post.volume*scale >= 30) && (post.volume*scale < 100))
        lucro = 2.47143 - (0.4/70)*post.volume*scale
      elsif ((post.volume*scale >= 100) && (post.volume*scale < 600))
        lucro = 1.94 - 0.0004*post.volume*scale
      elsif post.volume*scale >= 600
        lucro = 1.7
      end
      preco = ((precoMatDesg + precoEnerg)*(lucro + 1)).round(2)
      preco = '%.2f' % preco.round(2)


      #preco = (material.preco*volume + post.preco).round(2)
      @order.peso = peso.round(2)
      @order.price = preco
      @order.post_id = post.id
      @order.user_id = current_user.id

      if @order.save
        if params[:apenas_adicionar]
          respond_to do |format|
              format.html {redirect_to new_order_path(carrinho_id: carrinho.id)}
              format.js
            end
          else
            redirect_to carrinho_path(current_user.user_name)
      end
    end 
  end
  def checkouts
    transaction = PagSeguro::Transaction.find_by_notification_code(params[:notificationCode])
    if transaction.errors.empty?
      puts "DATA: #{transaction.created_at}"
      puts "DATA: #{transaction.code}"
      puts "DATA: #{transaction.gross_amount}"
      puts "DATA: #{transaction.payment_method.type}"
    end
  end
private
def order_params
    params.require(:order).permit(:quantidade,:color,:material,:resolution,:preench,:price,:scale)
  end
end
