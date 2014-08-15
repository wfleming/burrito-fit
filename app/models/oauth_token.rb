class OauthToken < ActiveRecord::Base
  belongs_to :user

  validates :uid, :token, :secret, :provider, presence: true
  validates :uid, :token, :secret, uniqueness: { scope: :provider }
end
