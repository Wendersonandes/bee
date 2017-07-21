class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    puts @user.errors.to_a
    puts request.env["omniauth.auth"]
    user_name = "#{@user.name}_#{@user.sobrenome}".downcase
    if user_name.include? ' '
      user_name.gsub!(' ', '_')
    end

    users = User.all.where("lower(completo) like ?", "#{@user.completo.downcase}%")

    if users.count > 1
      id = users.last.id + 1
      user_name = "#{@user.name}_#{@user.sobrenome}_#{id}".downcase
      if user_name.include? ' '
        user_name.gsub!(' ', '_')
      end
    end

    @user.update_attribute(:user_name, user_name)
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
    #Follow.create(follower_id: @user.id, following_id: @user.id)
    redirect_to new_user_registration_url
    end
  end
 
  def failure
    redirect_to root_path
  end
end