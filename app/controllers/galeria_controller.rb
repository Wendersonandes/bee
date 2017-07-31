class GaleriaController < ApplicationController
  layout :determine_layout
  def index
    @filtro = 0
  	@posts = Post.all.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
  	respond_to do |format|
      format.html
      format.js
  	end
  end

  def Arte
    @filtro = 1
  	@posts = Type.find_by_id(1).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Fashion
    @filtro = 2
    @posts = Type.find_by_id(2).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Gadgets
    @filtro = 3
    @posts = Type.find_by_id(3).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Hobby
    @filtro = 4
    @posts = Type.find_by_id(4).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Casa
    @filtro = 5
    @posts = Type.find_by_id(5).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Aprendizado
    @filtro = 6
    @posts = Type.find_by_id(6).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Modelos
    @filtro = 7
    @posts = Type.find_by_id(7).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Ferramentas
    @filtro = 8
    @posts = Type.find_by_id(8).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Brinquedos
    @filtro = 9
    @posts = Type.find_by_id(9).posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
        respond_to do |format|
      format.html
      format.js
    end
  end
  def Outros
    @filtro = 10
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
