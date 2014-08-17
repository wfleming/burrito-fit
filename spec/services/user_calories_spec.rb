require 'rails_helper'
require 'timecop'

RSpec.describe UserCalories do
  before do
    @user = FactoryGirl.build_stubbed(:user)
  end
  subject { UserCalories.new(@user) }

  it { expect(subject.user).to eq(@user) }

  describe '#calorie_balance' do
    before do
      @now = Time.now
      Timecop.freeze (@now - 1.day) do
        CalorieLog.create(user: @user, calories: 300, fitbit_date: Date.today)
      end
      Timecop.freeze @now do
        2.times do
          CalorieLog.create(user: @user, calories: 300, fitbit_date: Date.today)
        end
      end
    end

    it { expect(subject.calorie_balance).to eq(900) }
    it { expect(subject.calorie_balance(@now.to_date)).to eq(600) }
  end

  describe '#last_known_calorie_date' do
    context 'with no calorie data' do
      it do
        Timecop.freeze do
          expect(subject.last_known_calorie_date).to eq(Date.today)
        end
      end
    end

    context 'with some calorie data' do
      before do
        @yesterday = (Time.now - 1.day)
        Timecop.freeze @yesterday do
          CalorieLog.create(user: @user, calories: 300, fitbit_date: Date.today)
        end
      end

      it do
        expect(subject.last_known_calorie_date).to eq(@yesterday.to_date)
      end
    end
  end

  describe '#dates_needing_data' do
    before { Timecop.freeze }
    after { Timecop.return }
    context 'with no calorie data' do
      it { expect(subject.dates_needing_data).to eq([Date.today]) }
    end

    context 'with calorie data for today' do
      before { CalorieLog.create(user: @user, calories: 300, fitbit_date: Date.today) }

      it { expect(subject.dates_needing_data).to eq([Date.today]) }
    end

    context 'with calorie data for a few days ago' do
      before do
        CalorieLog.create(
          user: @user,
          calories: 300,
          created_at: (Time.now - 3.days).noon,
          fitbit_date: (Time.now - 3.days).to_date
        )
      end

      it do
        expected = [
          (Time.now - 3.days).to_date,
          (Time.now - 2.days).to_date,
          (Time.now - 1.day).to_date,
          Date.today,
        ]
        expect(subject.dates_needing_data).to eq(expected)
      end
    end
  end
end
