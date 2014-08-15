class OauthToken < ActiveRecord::Base
  belongs_to :user

  validates :user, :uid, :token, :secret, :provider, presence: true
  validates :user_id, :uid, :token, :secret, uniqueness: { scope: :provider }
end
