class CreateFitbitSubscriptionWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.fitbit.create_subscription(
      type: [:activities, :food],
      subscriptionId: user.id
    )
  end
end
