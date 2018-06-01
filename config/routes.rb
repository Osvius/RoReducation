Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'welcome/index'

  resource :users do
    member do
      get 'confirm_registration'
    end
  end
  # resources :posts

  root 'welcome#index'
end
