unless Rails.application.credentials.secret_key_base
  secret = ENV["SECRET_KEY_BASE"]
  if secret
    Rails.application.config.secret_key_base = secret
  end
end
