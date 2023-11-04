require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to post' do
      user = User.create(name: 'John')
      post = Post.create(title: 'Post Title', author: user)

      Like.new(user:, post:)

      assoc = described_class.reflect_on_association(:post)
      expect(assoc.macro).to eq :belongs_to
    end
  end

  describe 'callbacks' do
    it 'increments the posts likes counter' do
      user = User.create(name: 'Jane')
      post = Post.create(title: 'Great Post', author: user)

      expect do
        Like.create(user:, post:)
      end.to change { post.reload.likes_counter }.from(0).to(1)
    end
  end
end
