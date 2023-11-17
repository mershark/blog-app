module Api
  module V1
    class CommentsController < ApplicationController
      skip_before_action :verify_authenticity_token

      # GET /users/:user_id/posts/:post_id/comments
      def index
        post = User.find(params[:user_id]).posts.find(params[:post_id])
        comments = post.comments
        render json: comments
      end

      # POST /users/:user_id/posts/:post_id/comments
      def create
        post = User.find(params[:user_id]).posts.find(params[:post_id])
        comment = post.comments.new(comment_params)
        comment.user = User.find(params[:user_id])

        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors }, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
