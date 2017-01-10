class RelationshipsController < ApplicationController
  def follow_user
    @user = User.find_by! id: params[:id]
    if current_user.follow @user.id
      @user.update_attribute(:seguidores, @user.followers.count-1)
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.js
      end
    end
  end

  def unfollow_user
    @user = User.find_by! id: params[:id]
    if current_user.unfollow @user.id
      @user.update_attribute(:seguidores, @user.followers.count-1)
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.js
      end
    end
  end
end 
