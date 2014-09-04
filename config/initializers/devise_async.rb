# Supported options: :resque, :sidekiq, :delayed_job
Devise::Async.enabled = true
Devise::Async.backend = :sidekiq
