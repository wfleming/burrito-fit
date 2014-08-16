# fetch needed records from the
class CalorieFetcher
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def fetch
    user_calories.dates_needing_data.each do |date_midnight|
      puts "going to fetch for #{date_midnight}"
      fetch_for_day(date_midnight)
    end
  end

  private

  def user_calories
    @user_calories ||= UserCalories.new(user)
  end

  def fetch_for_day(day)
    #TODO: probably need to pay attention to user's UTC offset (from Fitbit API)
    #TODO: simplify by tagging logs with 'fitbit_date', use that for everything?
    #  if I do that, and use the same date for the API call, I mostly avoid timezone math!
    cals = user.fitbit.activities_for_day(day)['summary']['activityCalories']
    puts "cals for #{day} is #{cals}"
    # determine cals already recorded for this day
    already_cals = user_calories.calorie_balance(day)
    puts "already_cals for #{day} is #{already_cals}"
    if already_cals < cals
      CalorieLog.create!(user: user, calories: (cals - already_cals))
    elsif already_cals > cals
      Rails.logger.error <<-ERR.split("\n").map(&:strip).join(' ')
        more cals known already for user #{user.id} on #{day}:
        we know #{already_cals} but API gave us #{cals}
      ERR
    end
  end
end
