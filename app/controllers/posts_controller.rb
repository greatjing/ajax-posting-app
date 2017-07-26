class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    # @posts = Post.order("id DESC").all
    # 页面无限捲袖功能，显示20行
    @posts = Post.order("id DESC").limit(20)

    # 查询比max——id小的post id，定params参数
    if params[:max_id]
      @posts = @posts.where("id < ?", params[:max_id])
    end

# respond_to 可以让rails根据请求格式（在$ajax制定dataType），来回传不同格式
    respond_to do |format|
      format.html # 如果客户端要求html，则回传index.html.erb
      format.js #如果客户端要求javascript，回传 index.js.erb
    end

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

    # 使用回传json
    render :json => { :id => @post.id }
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
