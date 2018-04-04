Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = "reply@example.com"
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.rotate_csrf_on_sign_in = true
end
