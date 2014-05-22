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
  end

  resources :events do
    resources :comments
  end

  resources :posts do
    resources :comments
  end
  
  resources :hoas, except: [:show]
  get '/organisation',          to: 'hoas#show',       as: :organisation
  get '/organisation/members',  to: 'hoas#members',    as: :members
  get '/organisation/billing',  to: 'hoas#billing',    as: :billing
  get '/organisation/settings', to: 'hoas#settings',   as: :settings
  
  resources :participations
  resources :users, only: [:show]
  post '/users/:id/remove', to: 'users#remove_from_hoa', as: :remove_from_hoa

  get '/welcome', to: 'welcome#welcome', as: :welcome

  get   '/profile',         to: 'profile#index',  as: :profile
  get   '/profile/edit',    to: 'profile#edit',   as: :edit_profile
  patch '/profile/update',  to: 'profile#update', as: :update_profile


  constraints(Subdomain) do
    get '/' => 'homepages#show', as: :public_homepage
  end

  root to: 'dashboard#index'

  post '/ufgjdiie/:id', to: 'admin#change_hoa', as: :change_hoa

  # statistics
  get '/ieifjfnmvnskfogihjwowpflkfjskj', to: 'statistics#user_count'
  get '/jjoqoiwoieoriueriuisodsodofiio', to: 'statistics#hoa_count'

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
