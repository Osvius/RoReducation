Rails.application.routes.draw do
  get 'welcome/index'

  resource :users do
    member do
      get 'confirm_registration'
    end
  end
  # resources :posts

  root 'welcome#index'
end
