require 'rails_helper'

RSpec.describe 'New Post', type: :feature do
  let(:user) { User.create(name: 'John') }

  before { visit new_user_post_path(user) }

  it 'displays the new post form' do
    expect(page).to have_content('Create a New Post')
    expect(page).to have_field('Title')
    expect(page).to have_field('Text')
    expect(page).to have_button('Create Post')
  end

  it 'creates a new post on form submission' do
    fill_in 'Title', with: 'New Post Title'
    fill_in 'Text', with: 'This is the content of the new post.'
    click_button 'Create Post'

    expect(page).to have_current_path(user_posts_path(user))
  end
end
