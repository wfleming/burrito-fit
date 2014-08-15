class CalorieLog < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :calories, presence: true
  validates :calories, numericality: { only_integer: true }
end
