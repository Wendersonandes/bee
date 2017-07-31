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

  def Arte
  	@posts = Type.find_by_id(1).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Fashion
    @posts = Type.find_by_id(2).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Gadgets
    @posts = Type.find_by_id(3).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Hobby
    @posts = Type.find_by_id(4).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Casa
    @posts = Type.find_by_id(5).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Aprendizado
    @posts = Type.find_by_id(6).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Modelos
    @posts = Type.find_by_id(7).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Ferramentas
    @posts = Type.find_by_id(8).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Brinquedos
    @posts = Type.find_by_id(9).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Outros
    @posts = Type.find_by_id(10).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end

private
  def determine_layout
      case action_name
      when ""
        false
      end
    end


end
