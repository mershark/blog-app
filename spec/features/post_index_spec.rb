require 'rails_helper'

RSpec.describe 'User Post Index Page', type: :feature do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post1) { Post.new(author: user, title: 'Post 1', text: 'This is the first post.') }
  let(:post2) { Post.new(author: user, title: 'Post 2', text: 'This is the second post.') }
  let(:comment) { Comment.new(user:, post: post1, text: 'This is a comment.') }

  before do
    user.save
    post1.save
    post2.save
    comment.save
    visit user_posts_path(user)
  end

  it 'shows the user\'s profile picture' do
    expect(page).to have_selector("img[src='#{user.photo}']")
  end

  it 'shows the user\'s username' do
    expect(page).to have_content(user.name)
  end

  it 'shows the number of posts the user has written' do
    expect(page).to have_content("Number of Posts: #{user.posts_counter}")
  end

  it 'shows a post\'s title' do
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
  end

  it 'shows some of the post\'s body' do
    expect(page).to have_content(post1.text)
    expect(page).to have_content(post2.text)
  end

  it 'shows the first comments on a post' do
    expect(page).to have_content(comment.text)
  end

  it 'shows how many comments a post has' do
    expect(page).to have_content("Comments: #{post1.comments_counter}")
    expect(page).to have_content("Comments: #{post2.comments_counter}")
  end

  it 'shows how many likes a post has' do
    expect(page).to have_content("Likes: #{post1.likes_counter}")
    expect(page).to have_content("Likes: #{post2.likes_counter}")
  end

  it 'shows a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_selector('.see-all-button-container a', text: 'Pagination')
  end

  it 'redirects me to that post\'s show page when clicking on a post' do
    click_link post1.title
    expect(page).to have_current_path(user_post_path(user, post1))
  end
end
