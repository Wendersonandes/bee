class CarrinhosController < ApplicationController
	def create
		if current_user.carrinhos.where(:status => 'criado').any?
			@carrinho = current_user.carrinhos.find_by(:status => 'criado')
		else
			@carrinho = current_user.carrinhos.build(status: 'criado')
		end
		@order = carrinho.orders.build(order_params)
	end
	def index
		@orders = current_user.carrinhos.last.orders
	end
end
