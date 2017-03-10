class PedCommentsController < ApplicationController
	before_action :set_pedido

def create  
  @ped_comment = @pedido.ped_comments.build(ped_comment_params)
  @ped_comment.user_id = current_user.id

  if @ped_comment.save
    respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
  else
    flash[:alert] = "Check the comment form, something went horribly wrong."
    render pedido_path(current_user)
  end
end
def destroy  
  @ped_comment = @pedido.ped_comments.find(params[:ped_id])
  if @ped_comment.user_id == current_user.id
    @ped_comment.destroy
    respond_to do |format|
      format.html {redirect_to carrinho_path(current_user.user_name)}
      format.js
    end
  end
end

private

def ped_comment_params  
  params.require(:ped_comment).permit(:content)
end

def set_pedido
  @pedido = Pedido.find(params[:id])
end 
end
