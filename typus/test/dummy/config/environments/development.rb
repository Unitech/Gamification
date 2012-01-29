Dummy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Dear Developer,
  #
  # The following configuration option:
  #
  #   > Expands the lines which load the assets
  #
  # You might think in development this should be set to true, and you are
  # completely right, unless you reload pages a hundres of times a day.
  #
  # Change it to true if you need it, but please, do not commit your changes
  # to the repository.
  #
  # Best,
  #
  # - Francesc
  #
  config.assets.debug = false

  # Default url options for action mailer
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
end

Typus.setup do |config|
  config.mailer_sender = "admin@example.com"

  # Authenticate using `:none_with_role`
  # config.authentication = :none_with_role

  # Authenticate using `:http_basic` authentication.
  # config.authentication = :http_basic
  # config.username = 'admin'
  # config.password = 'columbia'

  # Authenticate using typus provided authentication.
  config.authentication = :session
  config.user_class_name = "AdminUser"

  # Authenticate using devise.
  # config.authentication = :devise
  # config.user_class_name = "DeviseUser"
end
