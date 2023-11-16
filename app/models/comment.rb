class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_save :update_comments_counter_for_post

  def user_is_admin?
    user.admin?
  end

  def update_comments_counter_for_post
    post.increment!(:comments_counter)
  end
end
