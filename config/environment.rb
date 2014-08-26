# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SMTP_USER_NAME'],
  :password => ENV['SMTP_PASSWORD'],
  :domain => ENV['SMTP_DOMAIN'],
  :address => ENV['SMTP_ADDRESS'],
  :port => ENV['SMTP_PORT'],
  :authentication => 'login',
  :enable_starttls_auto => true,
  :domain => 'fooball.herokuapp.com'
}