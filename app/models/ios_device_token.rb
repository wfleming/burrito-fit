# A device token for push notifications
class IosDeviceToken < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :token, uniqueness: { scope: :user }
end
