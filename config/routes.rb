Rails.application.routes.draw do
  resources :announcements

  resources :homepages

  resources :support_messages
  get '/help', to: 'support_messages#new', as: :help
  get '/updates', to: 'static_pages#updates', as: :updates

  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  mount RailsAdmin::Engine => '/superadmin', :as => 'rails_admin'

  resources :alerts do
    resources :comments
    resources :collaborations
    post '/remove_tag', to: 'alerts#remove_tag', as: :remove_tag
    post '/archive',    to: 'alerts#archive',     as: :archive
  end

  resources :events do
    resources :comments
  end

  resources :posts do
    resources :comments
  end

  resources :billing, only: [:new]

  resources :hoas, except: [:show] do
    collection do
      get 'check_subdomain_name'
    end
  end

  get '/organisation',          to: 'hoas#show',       as: :organisation
  get '/organisation/members',  to: 'hoas#members',    as: :members
  get '/organisation/settings', to: 'hoas#edit',   as: :settings

  get '/organisation/billing',         to: 'billing#index',    as: :billing
  get '/organisation/billing/renew',   to: 'billing#renew_subscription',    as: :renew
  get '/organisation/billing/confirm', to: 'billing#confirm_payment', as: :confirm_payment

  resources :participations
  resources :users, only: [:show, :edit, :update]
  post '/users/:id/remove', to: 'users#remove_from_hoa', as: :remove_from_hoa
  post '/users/:id/change_role', to: 'users#change_role', as: :change_role

  get '/welcome', to: 'hoas#new', as: :welcome

  get   '/profile',         to: 'profile#index',  as: :profile
  get   '/profile/edit',    to: 'profile#edit',   as: :edit_profile
  patch '/profile/update',  to: 'profile#update', as: :update_profile


  constraints(Subdomain) do
    get '/' => 'homepages#show', as: :public_homepage
  end

  root to: 'hoas#show'

  post '/ufgjdiie/:id', to: 'admin#change_hoa', as: :change_hoa

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
