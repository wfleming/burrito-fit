# Tracks calories a `User` "earns" or "spends".
# Calories are "earned" by burning them (doing activities).
# Calories are "spent" be eating (logging food, earning burritos)
# Positive calories amount are "earned", negative amounts are "spent"
#
# fitbit_date is the date the calories were earned or spent, within the
# user's fitbit timezone.
class CalorieLog < ActiveRecord::Base
  belongs_to :user
  has_one :burrito

  validates :user, :fitbit_date, :calories, presence: true
  validates :calories, numericality: { only_integer: true }

  def self.calorie_balance
    sum(:calories)
  end
end
