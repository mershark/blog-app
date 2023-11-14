require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'User Index Page', type: :feature do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.new(author: user, title: 'Hello', text: 'This is my first post') }
  let(:users) { User.all }

  before { user.save }

  context 'index page' do
    before { visit users_path }

    it 'shows the username of all other users' do
      users.each do |u|
        expect(page).to have_content(u.name)
      end
    end

    it 'shows the profile picture for each user' do
      users.each do |u|
        expect(page).to have_selector("img[src='#{u.photo}']")
      end
    end

    it 'shows the number of posts for each user' do
      users.each do |u|
        expect(page).to have_content("Posts: #{u.posts_counter}")
      end
    end

    it 'redirects to the user show page when clicking on a username' do
      visit users_path

      users.each do |user|
        click_link(user.name, match: :first, exact: false, href: user_path(user))
        expect(page).to have_current_path(user_path(user))
        visit users_path
      end
    end
  end
end
