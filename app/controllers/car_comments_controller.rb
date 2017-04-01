class CarCommentsController < ApplicationController
before_action :authenticate_user!
before_action :set_carrinho

def create  
  @car_comment = @carrinho.car_comments.build(car_comment_params)
  @car_comment.user_id = current_user.id
  if @car_comment.save
    create_notification(@carrinho, @car_comment)
    respond_to do |format|
    	format.html { redirect_to carrinho_path(current_user.user_name) }
    	format.js
    end	
  else
    flash[:alert] = "Check the comment form, something went wrong."
    render carrinho_path(current_user.user_name)
	end
	end
	
def destroy  
  @car_comment = @carrinho.car_comments.find(params[:id])
  if @car_comment.user_id == current_user.id
  	@car_comment.destroy
  	respond_to do |format|
  		format.html {redirect_to carrinho_path(current_user.user_name)}
  		format.js
  	end
  end
end

private

def create_notification(carrinho, comment)
    if carrinho.user.id == current_user.id
    	users = User.all.where(tipo: 'admin')
      	users.each do |admin|
      		Notification.create(user_id: admin.id,
                        notified_by_id: carrinho.user.id,
                        identifier: carrinho.id,
                        notice_type: "Por favor, responda o carrinho do #{carrinho.user.completo}",
                        status: "carrinho_admin")
      	end
   	else
    Notification.create(user_id: carrinho.user.id,
                        notified_by_id: Printer.last.user.id,
                        identifier: carrinho.id,
                        notice_type: "Você recebeu uma resposta em seu carrinho",
                        status: "carrinho")
	end

end



def car_comment_params  
  params.require(:car_comment).permit(:content)
end

def set_carrinho
  @carrinho = Carrinho.find(params[:carrinho_id])
end  
end
