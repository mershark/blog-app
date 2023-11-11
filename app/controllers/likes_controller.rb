class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])

    # Create the like directly through the association
    @like = @post.likes.create(user: current_user)

    if @like.save
      # Increment the likes_counter only if the like is successfully saved
      @post.update(likes_counter: @post.likes.count)
    else
      flash[:error] = 'Error saving like. Please try again.'
    end
    redirect_to user_post_path(@user, @post)
  end
end
