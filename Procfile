custom_web: bundle exec unicorn_rails -c config/unicorn.rb -E $RAILS_ENV -D
worker: env RAILS_ENV=$RAILS_ENV REDIS_URL=redis://$REDIS_ADDRESS bundle exec sidekiq

