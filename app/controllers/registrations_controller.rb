class RegistrationsController < Devise::RegistrationsController
  protected
  def stored_location_for(users)
  	nil
  end
  def after_sign_up_path_for(users)
    current_user.update_attribute(:completo, "#{current_user.name} #{current_user.sobrenome}")
    Follow.create(follower_id: current_user.id, following_id: current_user.id)
   	#profile_path(current_user.id)
    if session[:previous_url] == root_path
      profile_path(current_user.id)
    else
      session[:previous_url]
    end
  end
  def after_sign_out_path_for(users)
    ''
  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :name, :sobrenome, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :name, :sobrenome, :password, :password_confirmation, :current_password)
  end
end
