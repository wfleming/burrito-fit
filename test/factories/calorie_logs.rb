# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calorie_log do
    user
    calories 100
    fitbit_date Date.today
  end
end
