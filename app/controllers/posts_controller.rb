class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    @posts = Post.order("id DESC").all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

    # redirect_to posts_path
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    # redirect_to posts_path
    # render :js => "alert('ok');"
  end

#点赞
  def like
    @post = Post.find(params[:id])
    unless @post.find_like(current_user)
      Like.create( :user => current_user, :post => @post, :status => "like" )
    end

    #redirect_to posts_path
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    #redirect_to posts_path
    render "like"
  end

#收藏
  def collect
    @post = Post.find(params[:id])
    unless @post.find_collect(current_user)
      Like.create( :user => current_user, :post => @post, :status => "collect")
    end

  #redirect_to posts_path
  end

  def uncollect
    @post = Post.find(params[:id])
    like = @post.find_collect(current_user)
    like.destroy

    #redirect_to posts_path
    render "collect"
  end

  protected

  def post_params
    params.require(:post).permit(:content)
  end

end
