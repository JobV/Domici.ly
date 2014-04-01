source 'https://rubygems.org'

gem 'rails', '4.1.0.rc2'
gem 'sass-rails', '~> 4.0.1'

gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer',  platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'haml'

gem 'puma'

gem 'devise'
gem 'devise_invitable'

gem 'rails_admin'

gem 'rolify'
gem 'pundit'

# Bug tracking
gem 'bugsnag'
gem 'newrelic_rpm'

# Activity Feed => at release of 2.0, remove git ref.
gem 'public_activity', github: 'pokonski/public_activity'

# Tags
gem 'acts-as-taggable-on'

gem 'unread'

group :test, :development do
  gem 'factory_girl_rails', '~> 4.0'
  gem 'sqlite3'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
  gem 'capybara'
  gem 'rb-readline'
  gem 'launchy'
  gem 'quiet_assets'
end

group :development do
  gem "letter_opener"
  gem 'spring'
  gem 'annotate', github: 'ctran/annotate_models'
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
