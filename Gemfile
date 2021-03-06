source 'https://rubygems.org'

gem 'rails', '4.1.5'
gem 'sass-rails', '~> 4.0.1'
gem 'sass', '~> 3.2.18'

gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer',  platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'haml'
gem 'haml-rails'

gem 'unicorn'

# Devise
gem 'devise'
gem 'devise_invitable'
gem 'devise-async'

gem 'rails_admin'

gem 'rolify'
gem 'pundit'

# Bug tracking
# gem 'newrelic_rpm'
gem 'appsignal'

# Activity Feed => at release of 2.0, remove git ref.
gem 'public_activity', github: 'pokonski/public_activity'

# Tags
gem 'acts-as-taggable-on'

# Comments
gem 'acts_as_commentable'

# Date picker js
gem 'pikaday-gem'
gem 'momentjs-rails'

# Awesome dropdown
gem 'chosen-rails'

# Logentries
gem 'le'

# Sidekiq
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil

# List.js
gem 'listjs-rails'

# Redis
gem 'redis-rails'

# mollie
gem 'mollie-api-ruby'

# markdown
gem 'redcarpet'

# n progress
gem 'nprogress-rails'

# x-editable
gem 'x-editable-rails', '~> 1.5.4', github: 'JobV/x-editable-rails'

gem 'carrierwave'
gem 'fog'
gem 'foreigner'
gem 'active_model_serializers'


group :test, :development do
  gem 'factory_girl_rails', '~> 4.0'
  gem 'sqlite3'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-rspec', require: false
  gem 'capybara'
  gem 'rb-readline'
  gem 'launchy'
  gem 'quiet_assets'
  gem 'rspec-rails', '~> 3.0.0'
end

group :development do
  gem "letter_opener"
  gem 'spring'
  gem 'annotate', github: 'ctran/annotate_models'
  gem "binding_of_caller"
  gem "better_errors"
  gem 'flamegraph'
  gem 'immigrant'
end

group :test do
  gem 'simplecov', :require => false
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# bundle exec rake doc:rails generates the API under doc/api.
group :doc do
  gem 'sdoc', '~> 0.4.0'
end

gem 'rack-mini-profiler'
