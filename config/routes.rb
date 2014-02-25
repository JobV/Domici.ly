Rails.application.routes.draw do
  resources :alerts
  resources :posts
  resources :hoas


  root to: 'dashboard#index'

  devise_for :users
  resources :dashboard, only: [:index]
end
