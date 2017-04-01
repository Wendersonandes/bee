class CarrinhosController < ApplicationController
	before_action :set_user
	def index
		@carrinhos = @user.carrinhos.where.not(status: 'criado').order('created_at DESC')
		if params[:identifier]
			@carrinho = @user.carrinhos.find(params[:identifier])
		else
			@carrinho = @user.carrinhos.where.not(status: 'criado').last
		end
	end
	def show
		@carrinho = @user.carrinhos.find(params[:id])
		respond_to do |format|
        	format.html
        	format.js
        end
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
