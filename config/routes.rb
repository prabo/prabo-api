Rails.application.routes.draw do
  devise_for :user, only: []
  namespace :v1, defaults: { format: :json } do
    resources :login, only: [:create], controller: :sessions
    resources :users, only: [:index, :create, :show]
    resources :categories
    resources :missions, only: [:index, :create, :show, :update, :destroy] do
      post :complete
      post :uncomplete
    end
    get '*path', controller: 'application', action: 'render_404'
  end
end
