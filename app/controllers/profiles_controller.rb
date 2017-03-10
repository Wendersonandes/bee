class ProfilesController < ApplicationController
  before_action :authenticate_user!
  layout :determine_layout
  before_action :set_user
  before_action :owned_profile, only: [:edit, :update]

  def show
    if current_user != @user
      @user.update_attribute(:view, @user.view + 1)
    end
      #puts @user.avatar.url(:medium)
      @footers = Post.all.order('cached_votes_up DESC').first(6)
      @posts2 = @user.posts.limit(2);
      @posts = @user.posts.paginate(page: params[:page], per_page: 12).order('created_at DESC')
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
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def printers
    @printers = @user.printers.order('created_at DESC')
  end

  def destaques
    @posts = @user.posts.order('cached_votes_up DESC').first(5)
  end
  def projetos
      @posts = @user.posts.paginate(page: params[:page], per_page: 12).order('created_at DESC')
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
