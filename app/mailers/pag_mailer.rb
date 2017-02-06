class PagMailer < ApplicationMailer
	default from: "lucasfneves14@gmail.com"
	def print_email(user)
		@user = user
		mail(to: @user.email, subject: "Nova Impressão")
	end
end
