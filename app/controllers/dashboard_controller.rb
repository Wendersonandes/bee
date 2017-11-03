class DashboardController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user
	layout :false
	def index
		@sidenav = 'dashboard'

	end
	def usuarios
		@users = User.all.order('created_at DESC')
		@sidenav = 'usuarios'

	end
	def carrinhos
		@carrinhos = Carrinho.all.order('created_at DESC')
		@sidenav = 'carrinhos'

	end
	def vendas
		@vendas = Carrinho.where(status: 'Pago')
		@sidenav = 'vendas'
		@receita = 0
		@vendas.each do |venda|
			if @venda
				@receita = @receita + venda.price
			end
		end

	end


	private
	def set_user
		if current_user.tipo != 'admin'
			redirect_to galeria_path
		end
	end
end
