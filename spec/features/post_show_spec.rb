require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.new(author: user, title: 'Hello', text: 'This is my first post') }

  before { user.save }

  context 'Click' do
    it "redirects me to that post's show page when I click on a post" do
      visit_user_posts_path

      if user.posts.any?
        first_recent_post = user.recent_post[0]
        click_post_title(first_recent_post)
        expect(page).to have_current_path(user_post_path(user, first_recent_post))
      end
    end
  end

  context 'Show Page' do
    before { visit_first_recent_post }

    it "shows the post's title" do
      expect(page).to have_content(first_recent_post.title) if user.posts.any?
    end

    it "shows the post's author" do
      expect(page).to have_content(first_recent_post.author.name) if user.posts.any?
    end

    it 'shows how many likes the post has' do
      expect(page).to have_content("Likes: #{first_recent_post.likes_counter}") if user.posts.any?
    end

    it 'shows how many comments the post has' do
      expect(page).to have_content("Comments: #{first_recent_post.comments_counter}") if user.posts.any?
    end

    it 'shows the post body' do
      expect(page).to have_content(first_recent_post.text) if user.posts.any?
    end

    it 'shows the username of each commenter' do
      show_comment_usernames if user.posts.any? && first_recent_post.comments.any?
    end

    it 'shows the comment left by each commenter' do
      show_comments if user.posts.any? && first_recent_post.comments.any?
    end
  end

  private

  def visit_user_posts_path
    visit user_posts_path(user)
  end

  def click_post_title(post)
    click_link post.title
  end

  def visit_first_recent_post
    return unless user.posts.any?

    first_recent_post = user.recent_post[0]
    visit user_post_path(user, first_recent_post)
  end

  def first_recent_post
    user.recent_post[0]
  end

  def show_comment_usernames
    first_recent_post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  def show_comments
    first_recent_post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end