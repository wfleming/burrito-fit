class User < ActiveRecord::Base
  has_one :oauth_token

  def to_s
    oauth_token.extra_info['name']
  end
end
