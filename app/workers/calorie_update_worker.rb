class CalorieUpdateWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    CalorieFetcher.new(user).fetch
    user_calories = UserCalories.new(user)
    while user_calories.burrito_earned?
      user_calories.earn_burrito!
    end
  end
end
