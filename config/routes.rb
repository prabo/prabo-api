Rails.application.routes.draw do
  devise_for :user, only: []
  namespace :v1, defaults: { format: :json } do
    resources :login, only: [:create], controller: :sessions
    resources :users, only: [:create, :show]
    resources :categories
    resources :missions, only: [:index, :create, :show, :update, :destroy] do
      post :complete
      post :uncomplete
    end
  end
end
