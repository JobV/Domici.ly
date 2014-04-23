Rails.application.routes.draw do
  resources :support_messages
  get '/help', to: 'support_messages#new', as: :help

  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  mount RailsAdmin::Engine => '/superadmin', :as => 'rails_admin'

  resources :alerts do
    resources :comments
    post '/remove_tag', to: 'alerts#remove_tag', as: :remove_tag
  end

  resources :events do
    resources :comments
  end
  
  resources :posts
  resources :hoas
  resources :participations
  resources :users, only: [:show]
  post '/users/:id/remove', to: 'users#remove_from_hoa', as: :remove_from_hoa

  get '/welcome', to: 'welcome#welcome', as: :welcome

  get '/profile', to: 'profile#index', as: :profile
  get '/profile/edit', to: 'profile#edit', as: :edit_profile
  patch '/profile/update', to: 'profile#update', as: :update_profile

  root to: 'dashboard#index'

  resources :dashboard, only: [:index]

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
