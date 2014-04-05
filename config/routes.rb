Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/superadmin', :as => 'rails_admin'
  resources :alerts do
    resources :comments
  end
  resources :events do
    resources :comments
  end
  resources :posts
  resources :hoas

  get '/profile', to: 'profile#index', as: :profile
  get '/profile/edit', to: 'profile#edit', as: :edit_profile
  patch '/profile/update', to: 'profile#update', as: :update_profile

  root to: 'dashboard#index'

  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  resources :dashboard, only: [:index]
end
