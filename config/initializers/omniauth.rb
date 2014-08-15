Rails.application.config.middleware.use OmniAuth::Builder do
  secrets = Rails.application.secrets
  provider(:fitbit, secrets.fitbit_key, secrets.fitbit_secret)
end

OmniAuth.config.logger = Rails.logger
