require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV["REDISCLOUD_URL"],
    namespace: 'sidekiq',
    size: 1
  }
end

# https://devcenter.heroku.com/articles/forked-pg-connections#sidekiq
Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV["REDISCLOUD_URL"],
    namespace: 'sidekiq',
  }

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, pass|
  secrets = Rails.application.secrets
  [user, pass] == [secrets.admin_user, secrets.admin_pass]
end
