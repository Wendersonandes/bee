class ProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show, :projetos, :destaques,:printers,:seguidores, :seguindo]
  before_action :set_user
  before_action :owned_profile, only: [:edit, :update]

  def show
    if current_user != @user
      @user.update_attribute(:view, @user.view + 1)
    end
      #puts @user.avatar.url(:medium)
      @footers = Post.all.where.not(status: 0).order('cached_votes_up DESC').first(12)
      @posts2 = @user.posts.where.not(status: 0).limit(2);
      @posts = @user.posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
      @posts_all = @user.posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
      @botao = 'Projetos'
      respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      respond_to do |format|
        format.html {redirect_to profile_path(@user.user_name)}
        format.js
      end
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def printers
    @footers = Post.all.where.not(status: 0).order('cached_votes_up DESC').first(6)
    @printers = @user.printers.order('created_at DESC')
    @posts_all = @user.posts.where.not(status: 0).paginate(page: params[:page], per_page: 6).order('created_at DESC')
    @botao = 'Printers'
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destaques
    @footers = Post.all.where.not(status: 0).order('cached_votes_up DESC').first(6)
    @posts = @user.posts.where.not(status: 0).order('cached_votes_up DESC').first(6)
    @botao = 'Destaques'
    @posts_all = @user.posts.where.not(status: 0).paginate(page: params[:page], per_page: 6).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end
  def projetos
    @footers = Post.all.where.not(status: 0).order('cached_votes_up DESC').first(12)
    @posts = @user.posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
    @botao = 'Projetos'
    @posts_all = @user.posts.where.not(status: 0).paginate(page: params[:page], per_page: 12).order('created_at DESC')
    respond_to do |format|
        format.html
        format.js
    end
  end
  def seguidores
    @footers = Post.all.where.not(status: 0).order('cached_votes_up DESC').first(6)
    @botao = 'Seguidores'
    @posts_all = @user.posts.where.not(status: 0).paginate(page: params[:page], per_page: 6).order('created_at DESC')
    @seguidores = @user.followers
    respond_to do |format|
        format.html
        format.js
    end

  end
  def seguindo
    @footers = Post.all.where.not(status: 0).order('cached_votes_up DESC').first(6)
    @botao = 'Seguindo'
    @posts_all = @user.posts.where.not(status: 0).paginate(page: params[:page], per_page: 6).order('created_at DESC')
    @seguindo = @user.following
    respond_to do |format|
        format.html
        format.js
    end

  end

  def banco

  end
  private
  def determine_layout
  		case action_name
  		when "printers", "destaques", "projetos"
    		false
    	end
  	end

  def profile_params
    params.require(:user).permit(:conta_pais,:conta_nome,:conta_sobrenome,:conta_cpf,:conta_banco,:conta_agencia,:conta_tipo,:conta_num,
      :avatar, :bio, :prof, :city, :niver)
  end

  def owned_profile
    unless current_user == @user
      flash[:alert] = "That profile doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find_by(user_name: params[:user_name])
    puts @user.completo
  end

end
