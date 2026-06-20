Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? || ENV["RENDER"].present?
  config.active_storage.service = if ENV["RENDER"].present?
    :amazon
  else
    :local
  end

  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [:request_id]
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.action_mailer.default_url_options = { host: ENV["HOST"] || "antigravitylms.com" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV["SMTP_ADDRESS"],
    port: ENV["SMTP_PORT"] || 587,
    user_name: ENV["SMTP_USERNAME"],
    password: ENV["SMTP_PASSWORD"],
    authentication: :plain,
    enable_starttls_auto: true
  }

  config.force_ssl = true
end
