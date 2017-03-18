class PagMailer < ApplicationMailer
	default from: "lucasfneves14@gmail.com"
	def print_email(carrinho)
		@carrinho = carrinho
		@user = carrinho.user
		mail(to: User.first.email, subject: "Nova Impressão")
	end
end
 