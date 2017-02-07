class CkeckoutController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: :checkouts
	layout false
	def new
		@post = Post.find(params[:id])
	end
	def create
		post = Post.find(params[:id])
		material = params[:anything][:material]
		color = params[:anything][:color]
		resolution = params[:anything][:resolution]
		preench = params[:anything][:preench]
		redirect_to order_new_path(product_id: post.id, material: material, color: color, resolution: resolution, preench: preench)
    	#payment.extra_params << { material: params[:material] }
    	#payment.extra_params << { cor: params[:cor] }
    	#payment.extra_params << { preenchimento: params[:preenchimento] }
    	#payment.extra_params << { shell: params[:schell] 
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
