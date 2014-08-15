class User < ActiveRecord::Base
  has_one :oauth_token
end
