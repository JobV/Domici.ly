# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_domicily_session', domain: :all

if Rails.env == 'production' or Rails.env == 'development'
  Rails.application.config.session_store :redis_store, key: '_domicily_session', domain: {
    production: '.domici.ly',
    development: '.lvh.me'
  }.fetch(Rails.env.to_sym, :all)
else
  Rails.application.config.session_store :cookie_store, key: '_domicily_session', domain: :all
end
