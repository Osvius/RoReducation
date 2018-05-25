Rails.application.routes.draw do
  devise_scope :user do
    get 'users/password/change', to: 'users/registrations#change_password', as: "change_user_password"
    put 'users/password/update', to: 'users/registrations#update_password', as: "update_user_password"
    get 'users/password/update', to: 'users/registrations#update_password'
  end
  devise_for :users, controllers: {registrations: "users/registrations", passwords: "users/passwords"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  resources :posts

  root 'welcome#index'
end
