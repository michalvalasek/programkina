ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => "587",
  :domain => "gmail.com",
  :enable_starttls_auto => true,
  :authentication => :login,
  :user_name => "michal.valasek@gmail.com",
  :password => "ligkgvfxnndwzjlf"
}

config.action_mailer.raise_delivery_errors = true