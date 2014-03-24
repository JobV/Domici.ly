source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0.rc1'
gem 'sass-rails', '~> 4.0.1'

gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'


gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer',  platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'haml'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'puma'

gem 'devise'
gem 'devise_invitable'

gem 'rails_admin'

gem 'rolify'
gem 'pundit'

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
end

group :test do
  gem 'simplecov', :require => false
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
