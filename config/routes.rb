Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  get 'profile', to:'users#show'
  get 'profile/edit', to:'users#edit'
  patch 'profile/update', to:'users#update'

  resources :posts

  root 'welcome#index'
end
