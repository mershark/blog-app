require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'returns http success' do
      get '/users/1/posts'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/users/1/posts'
      expect(response).to render_template(:index)
    end

    it 'includes placeholder text' do
      get '/users/1/posts'
      expect(response.body).to include('Here is a list of posts for given user')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'returns http success' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get '/users/1/posts/1'
      expect(response).to render_template(:show)
    end

    it 'includes placeholder text' do
      get '/users/1/posts/1'
      expect(response.body).to include('Here are the details for given post')
    end
  end
end
