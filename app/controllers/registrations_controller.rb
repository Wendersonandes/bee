class RegistrationsController < Devise::RegistrationsController
  protected
  def stored_location_for(users)
  	nil
  end
  def after_sign_up_path_for(users)
    current_user.update_attribute(:completo, "#{current_user.name} #{current_user.sobrenome}")
    current_user.update_attribute(:tipo, "user")
    user_name = "#{current_user.name}_#{current_user.sobrenome}".downcase
    if user_name.include? ' '
      user_name.gsub!(' ', '_')
    end
    users = User.all.where("lower(completo) like ?", "#{current_user.completo.downcase}%")

    if users.count > 1
      id = users.last.id + 1
      user_name = "#{current_user.name}_#{current_user.sobrenome}_#{id}".downcase
      if user_name.include? ' '
        user_name.gsub!(' ', '_')
      end
    end

    current_user.update_attribute(:user_name, user_name)

    Follow.create(follower_id: current_user.id, following_id: current_user.id)
    if session[:previous_url] == root_path
      profile_path(current_user.user_name)
    else
      session[:previous_url]
    end
  end
  def after_sign_out_path_for(users)
    ''
  end
  def after_update_path_for(resource)
      current_user.update_attribute(:completo, "#{resource.name} #{resource.sobrenome}")
      browse_posts_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :name, :sobrenome, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :name, :sobrenome, :password, :password_confirmation, :current_password)
  end
end
