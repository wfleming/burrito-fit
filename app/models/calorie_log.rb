# Tracks calories a `User` "earns" or "spends".
# Calories are "earned" by burning them (doing activities).
# Calories are "spent" be eating (logging food, earning burritos)
# Positive calories amount are "earned", negative amounts are "spent"
class CalorieLog < ActiveRecord::Base
  belongs_to :user
  has_one :burrito

  validates :user, :calories, presence: true
  validates :calories, numericality: { only_integer: true }

  def self.calorie_balance
    sum(:calories)
  end
end
