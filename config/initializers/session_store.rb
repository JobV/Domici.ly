# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_domicily_session', domain: :all

# Rails.application.config.session_store :cookie_store, key: '_domicily_session', domain: {
#   production: '.domici.ly',
#   development: '.localhost'
# }.fetch(Rails.env.to_sym, :all)
