# A device token for push notifications
class IosDeviceToken < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
end
