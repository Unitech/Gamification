if File.exists?("config/email.yml")
  email_settings = YAML::load_file("config/email.yml")
  if (settings = email_settings[Rails.env])
    ActionMailer::Base.smtp_settings = settings
  end
end
