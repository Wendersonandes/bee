class GaleriaController < ApplicationController
  layout :determine_layout
  def index
  	@posts = Post.all.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
  	respond_to do |format|
      format.html
      format.js
  	end
  end
    def todos
  	@posts = Post.all.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
  	respond_to do |format|
      format.html
      format.js
  	end
  end

  def engenharia
  	@posts = Type.find_by_id(1).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def decoracao
  	@posts = Type.find_by_id(2).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def moda
  	@posts = Type.find_by_id(3).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def outros
  	@posts = Type.find_by_id(4).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
private
  def determine_layout
      case action_name
      when "todos", "engenharia", "decoracao", "moda", "outros"
        false
      end
    end


end
