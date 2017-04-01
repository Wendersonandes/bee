class NotificationsController < ApplicationController
	before_action :authenticate_user!
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    
    if @notification.status == 'pag_confirmation'
    	carrinho = Carrinho.find(@notification.identifier)
      if carrinho.status == 'criado'
        redirect_to carrinho_path(current_user.user_name)
      else
        redirect_to carrinhos_path(current_user.user_name,identifier: @notification.identifier)
      end

    elsif @notification.status == 'pag_confirmation_admin'
      carrinho = Carrinho.find(@notification.identifier)
      if carrinho.status == 'criado'
        redirect_to carrinho_path(@notification.notified_by.user_name)
      else
        redirect_to carrinhos_path(@notification.notified_by.user_name,identifier: @notification.identifier)
      end

    elsif @notification.status == 'post'
    	redirect_to post_path @notification.post

    elsif @notification.status == 'seguir'
      redirect_to profile_path(@notification.notified_by.user_name)

    elsif @notification.status == 'carrinho'
      carrinho = Carrinho.find(@notification.identifier)
      if carrinho.status == 'criado'
        redirect_to carrinho_path(current_user.user_name)
      else
        redirect_to carrinhos_path(current_user.user_name,identifier: @notification.identifier)
      end
    
    elsif @notification.status == 'carrinho_admin'
      carrinho = Carrinho.find(@notification.identifier)
      if carrinho.status == 'criado'
        redirect_to carrinho_path(current_user.user_name)
      else
        redirect_to carrinhos_path(current_user.user_name,identifier: @notification.identifier)
      end
    
    elsif @notification.status == 'pedido'
      redirect_to pedidos_path(user_name: current_user.user_name, identifier: @notification.identifier)
    
    elsif @notification.status == 'pedido_admin'
      redirect_to pedidos_path(user_name: @notification.notified_by.user_name, identifier: @notification.identifier)
    end
  end

  def index
    @notifications = current_user.notifications.order('created_at DESC')
  end
end
