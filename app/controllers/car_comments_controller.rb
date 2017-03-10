class CarCommentsController < ApplicationController
before_action :set_carrinho

def create  
  @car_comment = @carrinho.car_comments.build(car_comment_params)
  @car_comment.user_id = current_user.id
  if @car_comment.save
    respond_to do |format|
    	format.html { redirect_to carrinho_path(current_user.user_name) }
    	format.js
    end	
  else
    flash[:alert] = "Check the comment form, something went horribly wrong."
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
def car_comment_params  
  params.require(:car_comment).permit(:content)
end

def set_carrinho
  @carrinho = Carrinho.find(params[:carrinho_id])
end  
end
