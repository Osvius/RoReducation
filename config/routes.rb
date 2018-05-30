Rails.application.routes.draw do
  get 'welcome/index'

  resource :users
  # resources :posts

  root 'welcome#index'
end
