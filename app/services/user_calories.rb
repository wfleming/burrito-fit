# service for doing calculations/updates related to a user's calories log
class UserCalories
  attr_reader :user

  def initialize(user)
    @user = user
  end

  # Get the user's calorie balance.
  # If no date is given, it is the user's all-time balance.
  # If date is passed, it is only the balance earned on that day.
  # date should actually be a datetime, or timezones could make it wrong.
  def calorie_balance(date = nil)
    scope = user.calorie_logs
    if date
      range = [(date.utc.midnight)...(date.tomorrow.utc.midnight)]
      scope = scope.where(created_at: range)
    end
    scope.calorie_balance
  end

  # last date we have calorie data for, or today if there is no calorie date
  def last_known_calorie_date
    last_date = user.calorie_logs.maximum(:created_at)
    (last_date || Time.now).utc.midnight
  end

  # dates we should fetch data for
  def dates_needing_data
    today = Time.now.utc.midnight
    last_known = last_known_calorie_date
    dates = [last_known]
    while dates.last < today
      dates << dates.last.tomorrow.midnight.utc
    end
    dates
  end

  # true if the user has enough calories for a burrito
  def burrito_earned?
    calorie_balance >= Burrito::CALORIES
  end

  # Creates a Burrito
  def earn_burrito!
    user.burritos.create!(
      CalorieLog.create!(
        user: user,
        calories: (0 - Burrito::CALORIES)
      )
    )
  end
end
