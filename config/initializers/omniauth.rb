Rails.application.config.middleware.use OmniAuth::Builder do
  secrets = Rails.application.secrets
  provider(
    :fitbit, secrets.fitbit_key, secrets.fitbit_secret,
    setup: lambda do |env|
      user_agent = env['HTTP_USER_AGENT']
      if /Mobile/ =~ user_agent
        env['omniauth.strategy'].options[:authorize_params][:display] = 'touch'
      end
    end
  )
end

OmniAuth.config.logger = Rails.logger
