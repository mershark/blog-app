# spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      user = User.create(name: 'John')
      post = Post.create(title: 'Post', author: user)
      Comment.new(post:, user:)

      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'belongs to post' do
      user = User.create(name: 'John')
      post = Post.create(title: 'Hello', author: user)

      Comment.new(user:, post:)

      assoc = described_class.reflect_on_association(:post)
      expect(assoc.macro).to eq :belongs_to
    end
  end

  describe 'callbacks' do
    it 'increments the posts comments counter' do
      user = User.create(name: 'Jane')
      post = Post.create(title: 'Great Post', author: user)

      expect do
        Comment.create(user:, post:, text: 'Good post!')
      end.to change { post.reload.comments_counter }.from(0).to(1)
    end
  end
end
