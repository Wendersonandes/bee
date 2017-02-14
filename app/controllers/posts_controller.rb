class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.of_followed_users(current_user.following).order('created_at DESC')
  end
  def browse
    @sugestoes = (User.all.order('seguidores DESC') - current_user.following).first(6)
    @footers = Post.all.order('cached_votes_up DESC').first(6)  
    @posts = Post.all.paginate(page: params[:page], per_page: 12).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = @post.user
    @posts = @user.posts.where.not(id: @post.id).order('cached_votes_up DESC').first(6)
    @footers = Post.all.where.not(id: @post.id).order('cached_votes_up DESC').first(6)
    @printers = @user.printers.order('created_at DESC')
    @printers_all = Printer.all.order('created_at DESC')
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      converter @post
      flash[:success] = "Your post has been created!"
      redirect_to browse_posts_path
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
      redirect_to ṕosts_path
    else
      flash[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Your post has been deleted."
    redirect_to posts_path
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
      url: profile_path(user.id)
    }
    end
    render json: users
  end
  def autocompletepre2
      posts = Post.all.map do |post|
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
    posts = Post.starts_with(params[:query]).map do |post|
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
        url: profile_path(user.id)
      }
    end
    render json: users
    #render json: User.search(params[:query], autocomplete: true, limit: 10).map {|user|
     # { completo: user.completo, value: user.id, image: user.avatar.url(:medium), url: profile_path(user.id)}}
  end



  private
  def create_notification(post)  
    return if post.user.id == current_user.id 
    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: current_user.id,
                        notice_type: "#{current_user.completo} gostou do seu Post")
  end 




  def post_params
    params.require(:post).permit(:attachment,:image, :caption, :volume, type_ids:[])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to posts_path
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
    name ||= "#{Rails.root}/public/uploads/post/#{post.id}/#{File.basename(post.attachment.path)}"
    original = File.new(name, "r")
    tempLine = original.gets
    if tempLine.include? "solid"
      outFilename = name.sub(/\.stl/i, '-binary.stl')
      puts "#{name} is in ASCII format, converting to BINARY: #{outFilename}"
      outFile = File.new(outFilename, "w+b")
      outFile.write("\0" * 80) # 80 bit header - ignored
      outFile.write("FFFF")   # 4 bit integer # of triangles - filled later
      triCount = 0
      while temp = original.gets
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
      end
      outFile.seek(80, IO::SEEK_SET)
      outFile.write([ triCount ].pack("V"))
      outFile.close
      File.delete(name)
    else
      File.rename(name,"#{Rails.root}/public/uploads/post/#{post.id}/#{File.basename(post.attachment.path, ".*")}-binary.stl" )
    end
    original.close
  end

end
