Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

# https://devcenter.heroku.com/articles/forked-pg-connections#sidekiq
Sidekiq.configure_server do |config|
  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end
end
