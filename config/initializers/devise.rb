Devise.setup do |config|
  config.mailer_sender = "contato@antigravitylms.com"
  config.mailer = "Devise::Mailer"
  config.parent_mailer = "ActionMailer::Base"

  config.scoped_views = true
  config.default_scope = :user

  config.authentication_keys = [:email]
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.lock_strategy = :failed_attempts
  config.unlock_keys = [:email]
  config.unlock_strategy = :email
  config.maximum_attempts = 5
  config.last_attempt_warning = true
end
