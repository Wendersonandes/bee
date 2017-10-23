class HomeController < ApplicationController
	layout :determine_layout
  skip_before_action :verify_authenticity_token
  def index
    @contato = Contato.new
    @posts = Post.all.where.not(status: 0).order('cached_votes_up DESC').limit(9)
    @oferta = Ofert.new
  end

  def search
      @posts = Post.starts_with(params[:query]).where.not(status: 0).order('created_at DESC')
      @users = User.starts_with(params[:query]).order('created_at DESC')
      @query = params[:query]
  end
  def create
    @contato = Contato.create(contato_params)
    if @contato.save
      redirect_to root_path
    end
  end
  def create_oferta
    @oferta = Ofert.create(ofert_params)
    if @oferta.save
      redirect_to root_path
    end
  end
  def godaddy
  end

  private

  def contato_params
    params.require(:contato).permit(:name,:email,:mensagem)
  end
  def ofert_params
    params.require(:ofert).permit(:email)
  end
  def determine_layout
  		case action_name
  		when "index", "godaddy"
    		false
    	end
  end
end
