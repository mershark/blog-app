require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'validates presence of title' do
      post = Post.new(title: nil)
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'validates length of title' do
      post = Post.new(title: 'a' * 251)
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end
  end

  describe 'associations' do
    it 'belongs to author' do
      assoc = described_class.reflect_on_association(:author)
      expect(assoc.macro).to eq :belongs_to
    end
  end

  describe 'callbacks' do
    it 'increments author posts_counter on create' do
      user = User.create(name: 'John Doe', posts_counter: 0)


      expect do
        Post.create(title: 'Hello', author: user)
      end.to change { user.reload.posts_counter }.by(1)
    end
  end

  describe '#most_recent_comments' do
    it 'returns the 5 most recent comments' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'Post', author: user)

      # Create comments associated with the post
      comment1 = Comment.create(post:, user:, text: 'Comment 1')
      comment2 = Comment.create(post:, user:, text: 'Comment 2')

      # Call the most_recent_comments method
      recent_comments = post.most_recent_comments

      # Test that recent_comments contains the expected comments
      expect(recent_comments).to eq([comment2, comment1])
    end
  end
end
