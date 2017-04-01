class PedidosController < ApplicationController
	before_action :set_user
	def index
		@pedidos = @user.pedidos.order('created_at DESC')
		if params[:identifier]
			@pedido = @user.pedidos.find(params[:identifier])
		else
			@pedido = @user.pedidos.last
		end
	end
	def show
		@pedido = @user.pedidos.find(params[:id])
		respond_to do |format|
        format.html
        format.js
      end
	end
	def new
		
	end

	def create
		@pedido = @user.pedidos.build
		if @pedido.save
      		flash[:success] = "Your post has been created!"
      		redirect_to pedidos_path
    	else
      		flash[:alert] = "Your new post couldn't be created!  Please check the form."
      		render :new
    	end
	end

	def destroy_all
		@user.pedidos.destroy_all
		redirect_to pedidos_path
	end

	def destroy
		@pedido = @user.pedidos.find(params[:id])
		@pedido.destroy
		redirect_to pedidos_path
	end
	private
	def set_user
		@user = User.find_by(user_name: params[:user_name])
		if (@user != current_user)
			if(current_user.tipo!='admin')
				redirect_to browse_posts_path
			end
		end
	end
end
