require 'rails_helper'
require 'timecop'

RSpec.describe UserCalories do
  before do
    @user = User.new
  end
  subject { UserCalories.new(@user) }

  it { expect(subject.user).to eq(@user) }

  describe '#calorie_balance' do
    before do
      @now = Time.now
      Timecop.freeze (@now - 1.day) do
        CalorieLog.create(user: @user, calories: 300)
      end
      Timecop.freeze @now do
        2.times { CalorieLog.create(user: @user, calories: 300) }
      end
    end

    it { expect(subject.calorie_balance).to eq(900) }
    it { expect(subject.calorie_balance(@now)).to eq(600) }
  end

  describe '#last_known_calorie_date' do
    context 'with no calorie data' do
      it do
        Timecop.freeze do
          expect(subject.last_known_calorie_date).to eq(Time.now.utc.midnight)
        end
      end
    end

    context 'with some calorie data' do
      before do
        @yesterday = (Time.now - 1.day)
        Timecop.freeze @yesterday do
          CalorieLog.create(user: @user, calories: 300)
        end
      end

      it do
        expect(subject.last_known_calorie_date).to eq(@yesterday.utc.midnight)
      end
    end
  end

  describe '#dates_needing_data' do
    before { Timecop.freeze }
    after { Timecop.return }
    context 'with no calorie data' do
      it { expect(subject.dates_needing_data).to eq([Time.now.utc.midnight]) }
    end

    context 'with calorie data for today' do
      before { CalorieLog.create(user: @user, calories: 300) }

      it { expect(subject.dates_needing_data).to eq([Time.now.utc.midnight]) }
    end

    context 'with calorie data for a few days ago' do
      before do
        CalorieLog.create(
          user: @user, calories: 300, created_at: 3.days.ago.noon
        )
      end

      it do
        expected = [
          3.days.ago.utc.midnight,
          2.days.ago.utc.midnight,
          1.days.ago.utc.midnight,
          Time.now.utc.midnight,
        ]
        expect(subject.dates_needing_data).to eq(expected)
      end
    end
  end
end
