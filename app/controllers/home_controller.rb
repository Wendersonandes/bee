class HomeController < ApplicationController
	layout :determine_layout
  def index
  end

  def search
      #@posts = Post.search(params[:query])
      #@users = User.search(params[:query])
  end

  private
  def determine_layout
  		case action_name
  		when "index"
    		false
    	end
  end
end
