class CommentsController < ApplicationController
  before_action :set_user_and_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      # Update comments_counter only if the post is newly created
      @post.increment!(:comments_counter) if @post.new_record?
    else
      # Handle error
      flash[:error] = 'Error saving comment. Please try again.'
    end

    redirect_to user_post_path(@user, @post)
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
