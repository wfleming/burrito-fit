require 'rails_helper'

RSpec.describe CalorieLog, :type => :model do
  it { should belong_to(:user) }
  it { should have_one(:burrito) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:calories) }
  it { should validate_presence_of(:fitbit_date) }
  it { should validate_numericality_of(:calories).only_integer }

  describe '#calorie_balance' do
    before do
      @users = [User.create, User.create]
      CalorieLog.create(user: @users[0], calories: 200, fitbit_date: Date.today)
      CalorieLog.create(user: @users[1], calories: 300, fitbit_date: Date.today)
      CalorieLog.create(user: @users[0], calories: 200, fitbit_date: Date.today)
      CalorieLog.create(user: @users[1], calories: 300, fitbit_date: Date.today)
    end

    it { expect(CalorieLog.calorie_balance).to eq(1000) }
    it 'should respect conditions' do
      scope = CalorieLog.where(user_id: @users[0].id)
      expect(scope.calorie_balance).to eq(400)
    end
  end
end
