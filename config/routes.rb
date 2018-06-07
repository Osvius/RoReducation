Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/profile', to: 'profile#show'
  get '/profile/edit', to: 'profile#edit'
  patch '/profile/edit', to: 'profile#update'
  delete '/profile/delete', to: 'profile#destroy'
  get '/profile/password/change', to: 'profile#change_password'
  patch '/profile/password/change', to: 'profile#update_password'

  get 'welcome/index'

  resource :users do
    member do
      get 'confirm_registration'
    end
  end
  # resources :posts

  root 'welcome#index'
end
