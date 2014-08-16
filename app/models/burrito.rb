class Burrito < ActiveRecord::Base
  belongs_to :user
  belongs_to :calorie_log

  CALORIES = 500 # This is a kind of arbitrarily chosen rough average

  validates :user, :calorie_log, :presence => true
end
