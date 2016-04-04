ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:                "smtp.servername.com",
  port:                   587,
  domain:                 "nosh-up.com",
  user_name:              "maksym.pakhn.rails",
  password:               "maksym.pakhn.rails.",
  authentication:         "plain",
  enable_starttls_auto:   true
}
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
