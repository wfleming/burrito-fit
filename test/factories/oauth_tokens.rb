# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :oauth_token do
    provider 'fitbit'
    sequence(:token) {|n| "oauth-token-#{n}" }
    sequence(:secret) {|n| "oauth-secret-#{n}" }
    sequence(:uid) {|n| "uid-#{n}" }
    extra_info({
      "dob"=>"1985-03-14",
      "city"=>nil,
      "name"=>"William",
      "state"=>nil,
      "gender"=>"MALE",
      "locale"=>"en_GB",
      "country"=>"US",
      "about_me"=>nil,
      "nickname"=>nil,
      "timezone"=>"America/New_York",
      "full_name"=>"William Fleming",
      "display_name"=>"William",
      "member_since"=>"2014-02-24"
    })
  end
end
