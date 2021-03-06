class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :store_location
  def store_location
  # store last url as long as it isn't a /users path
  session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
end



  def after_sign_in_path_for(resource)
    if session[:previous_url] 
      session[:previous_url]
    else
      root_path
    end
  end
end
