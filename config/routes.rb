Rails.application.routes.draw do
  devise_for :user, only: []
  namespace :v1, defaults: { format: :json } do
    resources :login, only: [:create], controller: :sessions
    resources :users, only: [:create, :show]
  end
end
