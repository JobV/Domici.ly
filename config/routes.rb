Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/superadmin', :as => 'rails_admin'
  resources :alerts
  resources :posts
  resources :hoas

  get 'admin', to: 'admin#index', as: :admin

  root to: 'dashboard#index'

  devise_for :users
  resources :dashboard, only: [:index]
end
