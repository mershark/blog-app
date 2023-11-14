require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.new(author: user, title: 'Hello', text: 'This is my first post') }

  before { user.save }

  let(:first_user) { User.first }
  let(:first_user_posts) { first_user.posts }

  context 'show page' do
    before { visit user_path(first_user) }

    it 'shows profile picture' do
      expect(page).to have_selector("img[src='#{first_user.photo}']")
    end

    it 'shows user name' do
      expect(page).to have_content(first_user.name)
    end

    it 'shows number of posts by the user' do
      expect(page).to have_content("Number of Posts: #{first_user.posts_counter}")
    end

    it "shows a button that lets me view all of a user's posts" do
      expect(page).to have_selector('a', text: 'See All Posts')
    end

    it 'displays the first three posts and a "Show All" button' do
      first_post = first_user_posts[0]
      second_post = first_user_posts[1]
      third_post = first_user_posts[2]

      expect(page).to have_content(first_post.title) if first_post
      expect(page).to have_content(second_post.title) if second_post
      expect(page).to have_content(third_post.title) if third_post
      expect(page).to have_selector('a', text: 'See All Posts')
    end

    it "shows the user's bio" do
      expect(page).to have_content(first_user.bio)
    end
  end

  context 'Clicks' do
    before { visit user_path(first_user) }

    it "redirects me to the user's post on clicking on a post" do
      first_user_posts.each do |user_post|
        click_link user_post.title
        expect(page).to have_current_path(user_post_path(first_user, user_post))
        visit user_path(first_user)
      end
    end

    it "redirects me to the user's post clicking on see all posts" do
      click_link 'See All Posts'
      expect(page).to have_current_path(user_posts_path(first_user))
    end
  end
end
