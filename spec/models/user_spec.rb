require 'rails_helper'

RSpec.describe User, type: :model do
  # validations
  it 'validates presence of name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'validates numericality of posts_counter' do
    user = User.new(posts_counter: -1)
    expect(user).to_not be_valid
    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end

  # associations
  it 'has many posts' do
    association = described_class.reflect_on_association(:posts)
    expect(association.macro).to eq :has_many
  end

  it 'has many comments' do
    association = described_class.reflect_on_association(:comments)
    expect(association.macro).to eq :has_many
  end

  it 'has many likes' do
    association = described_class.reflect_on_association(:likes)
    expect(association.macro).to eq :has_many
  end

  describe '#most_recent_posts' do
    let(:user) { User.create(name: 'John') }

    it 'returns the 3 most recent posts' do
      # create posts
      post2 = Post.create(title: 'Second Post', author: user)
      post3 = Post.create(title: 'Third Post', author: user)
      post4 = Post.create(title: 'Fourth Post', author: user)

      expect(user.most_recent_posts).to eq([post4, post3, post2])
    end
  end
end
