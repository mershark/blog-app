Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show] do
      resources :comments, only: [:create]
      resources :likes 
    end
  end
end
