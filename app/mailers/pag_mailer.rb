class PagMailer < ApplicationMailer
	default from: "contato@beeprinted.com.br"
	def print_email(carrinho)
		@carrinho = carrinho
		@user = carrinho.user
		mail(to: User.first.email, subject: "Nova Impressão")
	end
end
 