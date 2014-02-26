Rails.application.routes.draw do
  resources :alerts
  resources :posts
  resources :hoas

  get 'admin', to: 'admin#index', as: :admin

  root to: 'dashboard#index'

  devise_for :users
  resources :dashboard, only: [:index]
end
