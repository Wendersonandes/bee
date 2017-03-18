class NotificationsController < ApplicationController
	before_action :authenticate_user!
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    if @notification.status == 'pag_confirmation'
    	redirect_to carrinho_path(current_user.user_name)
    else
    	redirect_to post_path @notification.post
    end
  end

  def index
    @notifications = current_user.notifications.order('created_at DESC')
  end
end
