class CkeckoutController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: :checkouts
	layout false
	def new
		@post = Post.find(params[:id])
	end
	def create
		post = Post.find(params[:id])
		payment = PagSeguro::PaymentRequest.new
		payment.reference = post.id
		payment.notification_url = "localhost:3000/checkouts"
		payment.redirect_url = "localhost:3000/browse"
		material = Printer.last.materials[0]
		volume = post.volume / 1000
		preco = material.preco*volume

		payment.items << {
			id: post.id,
			description: post.caption,
			amount: preco
		}
		payment.extra_params << { material: params[:anything][:material] }
		payment.extra_params << { material: params[:anything][:color] }
		payment.extra_params << { material: params[:anything][:resolution] }
		payment.extra_params << { material: params[:anything][:preench] }
    	#payment.extra_params << { material: params[:material] }
    	#payment.extra_params << { cor: params[:cor] }
    	#payment.extra_params << { preenchimento: params[:preenchimento] }
    	#payment.extra_params << { shell: params[:schell] 

    	response = payment.register

    	if response.errors.any?
    		raise response.errors.join("\n")
    	else 
    		redirect_to response.url
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

end
