class RelationshipsController < ApplicationController
  def follow_user
    @user = User.find_by! user_name: params[:user_name]
    if current_user.follow @user.id
      Notification.create(user_id: @user.id,
                        notified_by_id: current_user.id,
                        post_id: '',
                        identifier: current_user.id,
                        notice_type: "#{current_user.completo} começou a te seguir")
      @user.update_attribute(:seguidores, @user.followers.count-1)
      respond_to do |format|
        format.html { redirect_to profile_path(@user.user_name) }
        format.js
      end
    end
  end

  def unfollow_user
    @user = User.find_by! user_name: params[:user_name]
    if current_user.unfollow @user.id
      @user.update_attribute(:seguidores, @user.followers.count-1)
      respond_to do |format|
        format.html { redirect_to profile_path(@user.user_name) }
        format.js
      end
    end
  end
end 
