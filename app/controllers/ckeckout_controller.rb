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
	end
	def create
		if current_user.carrinhos.where(:status => 'criado').any?
      		carrinho = current_user.carrinhos.find_by(:status => 'criado')
    	else
     		carrinho = current_user.carrinhos.build(status: 'criado')
   		end
   		@order = carrinho.orders.build(order_params)

		post = Post.find(params[:id])
		material = Printer.last.materials.find_by(:name => @order.material)
		volume = post.volume / 1000
	  	preco = (material.preco*volume).round(2)

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
        		redirect_to new_order_path(carrinho_id: carrinho.id)
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
    params.require(:order).permit(:color,:material,:resolution,:preench,:price)
  end
end
