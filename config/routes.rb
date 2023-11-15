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
  
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show] do
      resources :comments, only: [:create]
      resources :likes 
    end
  end
end
