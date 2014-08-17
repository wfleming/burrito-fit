class CreateFitbitSubscriptionWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.fitbit.create_subscription(
      type: :activities,
      subscription_id: user.id
    )
  end
end
