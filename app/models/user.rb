class User < ActiveRecord::Base
  has_one :oauth_token
  has_many :calorie_logs

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
end
