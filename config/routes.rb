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

end
