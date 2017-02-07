class PagMailer < ApplicationMailer
	default from: "lucasfneves14@gmail.com"
	def print_email(order)
		@order = order
		@user = order.user
		@post = order.post
		mail(to: @order.printer.user.email, subject: "Nova Impressão")
	end
end
 