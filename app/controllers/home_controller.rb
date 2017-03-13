class HomeController < ApplicationController
	layout :determine_layout
  def index
  end

  def search
      @posts = Post.starts_with(params[:query]).where.not(status: 0).order('created_at DESC')
      @users = User.starts_with(params[:query]).order('created_at DESC')
      @query = params[:query]
  end

  private
  def determine_layout
  		case action_name
  		when "index"
    		false
    	end
  end
end
