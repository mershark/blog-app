class PostsController < ApplicationController
  before_action :set_user

  def index
    # Used 'includes' to eager load comments associated with each post
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to user_posts_path(@user)
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
