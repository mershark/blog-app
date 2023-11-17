Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'reset',
    confirmation: 'confirm',
    unlock: 'unlock',
    registration: 'sign_up',
    sign_up: ''
  }, controllers: {
    registrations: 'registrations'
  }

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :destroy, :show] do
      resources :comments, only: [:create, :destroy]
      resources :likes
    end
  end

  root "users#index"
  
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
    
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index] 
      end
  
      resources :posts, only: [] do  
        resources :comments, only: [:index, :create]
      end
    end
  end
end
