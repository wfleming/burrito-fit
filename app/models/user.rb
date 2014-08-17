class User < ActiveRecord::Base
  has_one :oauth_token
  has_many :calorie_logs
  has_many :burritos
  has_many :ios_device_tokens

  ### Callbacks ###
  before_save :ensure_api_token

  def to_s
    oauth_token.extra_info['name']
  end

  # a fitbit client for this user to make API requests
  def fitbit
    @fitgem_client ||= Fitgem::Client.new(
      consumer_key: Rails.application.secrets.fitbit_key,
      consumer_secret: Rails.application.secrets.fitbit_secret,
      token: oauth_token.token,
      secret: oauth_token.secret
    )
  end

  def fitbit_timezone
    ActiveSupport::TimeZone[oauth_token.extra_info['timezone']]
  end

  def ensure_api_token
    (self.api_token = generate_api_token) if api_token.blank?
  end

  def generate_api_token
    loop do
      token = SecureRandom.urlsafe_base64(25).tr('b6d7a39fey', '689f4udac7')
      break token unless User.where(:api_token => token).first
    end
  end
end
