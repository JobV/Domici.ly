Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/superadmin', :as => 'rails_admin'
  resources :alerts, except: [:index]
  resources :posts
  resources :hoas

  get '/profile', to: 'profile#index', as: :profile

  root to: 'dashboard#index'

  devise_for :users
  resources :dashboard, only: [:index]
end
