Rails.application.routes.draw do
  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  mount RailsAdmin::Engine => '/superadmin', :as => 'rails_admin'

  resources :alerts do
    resources :comments
  end

  resources :events do
    resources :comments
  end
  
  resources :posts
  resources :hoas
  resources :participations
  resources :users, only: [:show]

  get '/profile', to: 'profile#index', as: :profile
  get '/profile/edit', to: 'profile#edit', as: :edit_profile
  patch '/profile/update', to: 'profile#update', as: :update_profile

  root to: 'dashboard#index'

  resources :dashboard, only: [:index]
end
