# fetch needed records from the
class CalorieFetcher
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def fetch
    user_calories.dates_needing_data.each do |date|
      fetch_for_day(date)
    end
  end

  private

  def user_calories
    @user_calories ||= UserCalories.new(user)
  end

  def fetch_for_day(day)
    cals = user.fitbit.activities_on_date(day)['summary']['activityCalories']
    # determine cals already recorded for this day
    already_cals = user_calories.calorie_balance(day, true)
    if already_cals < cals
      CalorieLog.create!(
        user: user,
        calories: (cals - already_cals),
        fitbit_date: day
      )
    elsif already_cals > cals
      Rails.logger.error <<-ERR.split("\n").map(&:strip).join(' ')
        more cals known already for user #{user.id} on #{day}:
        we know #{already_cals} but API gave us #{cals}
      ERR
    end
  end
end
