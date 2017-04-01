class PedCommentsController < ApplicationController
	before_action :set_pedido

def create  
  @ped_comment = @pedido.ped_comments.build(ped_comment_params)
  @ped_comment.user_id = current_user.id

  if @ped_comment.save
    create_notification(@pedido, @ped_comment)
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

def create_notification(pedido, comment)
    if pedido.user.id == current_user.id
      users = User.all.where(tipo: 'admin')
      users.each do |admin|
        Notification.create(user_id: admin.id,
                        notified_by_id: pedido.user.id,
                        identifier: pedido.id,
                        notice_type: "Por favor, responda um pedido personalizado",
                        status: "pedido_admin")
      end
    else
    Notification.create(user_id: pedido.user.id,
                        notified_by_id: Printer.last.user.id,
                        identifier: pedido.id,
                        notice_type: "Você recebeu uma resposta em seu pedido personalizado",
                        status: "pedido")
    end
end


def ped_comment_params  
  params.require(:ped_comment).permit(:content)
end

def set_pedido
  @pedido = Pedido.find(params[:id])
end 
end
