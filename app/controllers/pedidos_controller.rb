class PedidosController < ApplicationController
	def index
		@pedidos = current_user.pedidos.order('created_at DESC')
		@pedido = current_user.pedidos.last
	end
	def show
		@pedido = current_user.pedidos.find(params[:id])
		respond_to do |format|
        format.html
        format.js
      end
	end
	def new
		
	end

	def create
		@pedido = current_user.pedidos.build
		if @pedido.save
      		flash[:success] = "Your post has been created!"
      		redirect_to pedidos_path
    	else
      		flash[:alert] = "Your new post couldn't be created!  Please check the form."
      		render :new
    	end
	end

	def destroy_all
		current_user.pedidos.destroy_all
		redirect_to pedidos_path
	end

	def destroy
		@pedido = current_user.pedidos.find(params[:id])
		@pedido.destroy
		redirect_to pedidos_path
	end
end
