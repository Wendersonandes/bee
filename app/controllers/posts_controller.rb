class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show, :autocompletepre, :autocompletepre2, :autocomplete, :autocomplete2]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.of_followed_users(current_user.following).where.not(status: 1).order('created_at DESC')
  end
  def browse
    @user = current_user
    @pedido = Pedido.new
    @sugestoes = (User.all.order('seguidores DESC') - current_user.following).first(4)
    @footers = Post.of_not_followed_users(current_user.following).where.not(status: 0).order('cached_votes_up DESC').limit(8) 



    @posts = Post.of_followed_users(current_user.following).where.not(status: 0).paginate(page: params[:page], per_page: 6).order('created_at DESC')
    @destaques = Post.of_not_followed_users(current_user.following).where.not(status: 0).order('cached_votes_up DESC')


    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    if current_user != @post.user
      @post.update_attribute(:view, @post.view + 1)
    end
    @materials = Printer.last.materials.order(:name)
    @user = @post.user
    @posts = @user.posts.where.not(id: @post.id, status: 0).order('cached_votes_up DESC').first(6)
    @footers = Post.all.where.not(id: @post.id, status: 0).order('cached_votes_up DESC').first(6)
    @printers = @user.printers.order('created_at DESC')
    @printers_all = Printer.all.order('created_at DESC')
    #@preco = ((@post.volume/1000) * Printer.last.materials[0].preco + @post.preco).round(2)
    @post.volume = @post.volume
    printer = Printer.last
    @area = @post.area
    material = printer.materials.find_by(name: 'PLA')
    @post.x = @post.x/10
    @post.y = @post.y/10
    @post.z = @post.z/10
    #shell = (@post.volume - @post.volume*(((@post.x - 0.16)/@post.x)*((@post.y - 0.16)/@post.y)*((@post.z - 0.1z)/@post.z)))
    @kwh = printer.kwh
    @desgaste = printer.desgaste
    #@peso = material.densidade*shell
    shell = @post.area*0.08
    percentShell = shell/@post.volume
    if percentShell > 1
      percentShell = 1
    end
    #shell = shell + 0.8*@post.area*0.04
    @peso = @post.volume*material.densidade*(percentShell + (1 - percentShell)*0.20)
    precoMatDesg = @peso*(0.13 + printer.desgaste*0.2/0.2)
    precoEnerg = ((@peso/8) + 0.2)*material.potencia*@kwh
    if ((@post.volume >= 0) && (@post.volume < 30))
      lucro = 3 - (0.7/30)*@post.volume
    elsif ((@post.volume >= 30) && (@post.volume < 100))
      lucro = 2.47143 - (0.4/70)*@post.volume
    elsif ((@post.volume >= 100) && (@post.volume < 600))
      lucro = 1.94 - 0.0004*@post.volume
    elsif @post.volume >= 600
      lucro = 1.7
    end
    @preco = ((precoMatDesg + precoEnerg)*(lucro + 1)).round(2)
    @preco = '%.2f' % @preco.round(2)


  end

  def new
    if current_user.tipo != 'admin'
      redirect_to galeria_path
    end
    @post = current_user.posts.build
  end

  def importar
  	@post = current_user.posts.build
  end

  def importar_create
  	@post = current_user.posts.build(import_params)
  	@post.caption = File.basename(@post.attachment.path)
  	@post.status = 0
    if @post.save
      converter @post
      flash[:success] = "Your post has been created!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.status = 1
    #converter @post
    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Your post has been deleted."
    redirect_to galeria_path
  end

  def like
    if @post.liked_by current_user
    	@post.update_attribute(:cached_votes_up, @post.votes_for.up.by_type(User).size)
      create_notification @post
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end
  def unlike
    if @post.unliked_by current_user
    	@post.update_attribute(:cached_votes_up, @post.votes_for.up.by_type(User).size)
          respond_to do |format|
            format.html { redirect_to :back }
            format.js
          end
      end
  end

  def autocompletepre
      users = User.all.map do |user|
    {
      completo: user.completo,
      value: user.id,
      image: user.avatar.url(:medium), 
      url: profile_path(user.user_name)
    }
    end
    render json: users
  end
  def autocompletepre2
      posts = Post.all.where.not(status: 0).map do |post|
    {
      caption: post.caption, 
      value: post.id, 
      image: post.user.avatar.url(:medium), 
      url: post_path(post.id), 
      user: post.user.name
    }
    end
    render json: posts
  end
  def autocomplete
    posts = Post.starts_with(params[:query]).where.not(status: 0).map do |post|
      {
        caption: post.caption,
        value: post.id,
        image: post.user.avatar.url(:medium),
        url: post_path(post.id)
      }
    end
    render json: posts

    #render json: Post.search(params[:query], autocomplete: true, limit: 10).map {|post|
     # { caption: post.caption, value: post.id, image: post.user.avatar.url(:medium), url: post_path(post.id), 
      #user: post.user.name }}
  end
  def autocomplete2
    users = User.starts_with(params[:query]).map do |user|
      {
        completo: user.completo,
        value: user.id,
        image: user.avatar.url(:medium),
        url: profile_path(user.user_name)
      }
    end
    render json: users
    #render json: User.search(params[:query], autocomplete: true, limit: 10).map {|user|
     # { completo: user.completo, value: user.id, image: user.avatar.url(:medium), url: profile_path(user.user_name)}}
  end



  private
  def create_notification(post)  
    return if post.user.id == current_user.id 
    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: current_user.id,
                        notice_type: "#{current_user.completo} gostou do seu Post",
                        status: "post")
  end 




  def post_params
    params.require(:post).permit(:attachment,:image, :caption, :volume, :area, :x, :y, :z, :preco, type_ids:[])
  end
  def import_params
    params.require(:post).permit(:attachment,:volume, :x, :y, :z, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to post_path(@post)
    end
  end
class Float
  def to_sn # to scientific notation
    "%E" % self
  end

  def self.from_sn str # generate a float from scientific notation
    ("%f" % str).to_f
  end
end
  def converter(post)
    name ||= "#{post.attachment.url}"
    originalname = name.sub(/\.stl/i, '-original.stl')
    File.rename(name, "#{originalname}" )
    original = File.new(originalname, "r")
    tempLine = original.gets
    if tempLine.include? "solid"
      outFilename = name
      puts "#{name} is in ASCII format, converting to BINARY: #{outFilename}"
      outFile = File.new(outFilename, "w+b")
      outFile.write("\0" * 80) # 80 bit header - ignored
      outFile.write("FFFF")   # 4 bit integer # of triangles - filled later
      triCount = 0
      puts "#{triCount}"
      while temp = original.gets
        if temp.valid_encoding?
      	 #temp.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
          next if temp =~ /^\s*$/ or temp.include? 'endsolid' # ignore whitespace
          temp.sub! /facet normal/, ''
          normal = temp.split(' ').map{ |num| Float.from_sn num }
          triCount += 1
          temp = original.gets # 'outer loop'

          temp = original.gets
          vertexA = temp.sub(/vertex/, '').split(' ').map{ |num| Float.from_sn num }
          temp = original.gets
          vertexB = temp.sub(/vertex/, '').split(' ').map{ |num| Float.from_sn num }
          temp = original.gets
          vertexC = temp.sub(/vertex/, '').split(' ').map{ |num| Float.from_sn num }

          temp = original.gets # 'endsolid'
          temp = original.gets # 'endfacet'

          outFile.write(normal.pack("FFF"))
          outFile.write(vertexA.pack("FFF"))
          outFile.write(vertexB.pack("FFF"))
          outFile.write(vertexC.pack("FFF"))
          outFile.write("\0\0")
        else
          #File.rename(name,"#{Rails.root}/public/uploads/post/#{post.id}/#{File.basename(post.attachment.path, ".*")}-binary.stl" ) 
          break
        end
      end
      if temp.valid_encoding?
        outFile.seek(80, IO::SEEK_SET)
        outFile.write([ triCount ].pack("V"))
        outFile.close
        File.delete(originalname)
      end
    else
      File.rename(originalname,name)
    end
    original.close
  end

end
