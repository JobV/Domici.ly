Rails.application.routes.draw do
  resources :hoas

  root to: 'dashboard#index'

  devise_for :users
  resources :posts
  resources :dashboard, only: [:index]
end
