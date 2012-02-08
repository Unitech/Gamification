Gamification::Application.configure do
  #
  # Gmail email sending for devise
  #
  require 'tlsmail'
  config.action_mailer.default_url_options = { :host => 'vote-system.com' }

  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
  
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,  #this is the important shit!
    :address        => 'smtp.gmail.com',
    :port           => 587,
    :domain         => 'xtargets.com',
    :authentication => :plain,
    :user_name      => 'votes.system@gmail.com',
    :password       => 'qko96e12'
  }
  
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  URL_SITE = 'http://localhost:3000/'
end
