require 'rails_helper'
require 'timecop'

RSpec.describe CalorieFetcher do
  before do
    Timecop.freeze
    @user = FactoryGirl.build_stubbed(:user)
  end
  after { Timecop.return }
  subject { CalorieFetcher.new(@user) }

  it { expect(subject.user).to eq(@user) }

  def date_in_user_timezone(time)
    (time.utc + @user.fitbit_timezone.utc_offset.seconds).to_date
  end

  describe '#fetch' do
    before do
      fitbit_double = double(:fitbit)
      yesterday = date_in_user_timezone(Time.now - 1.day)
      today = date_in_user_timezone(Time.now)
      allow(fitbit_double).to receive(:activities_on_date)
        .with(yesterday).and_return(
          {'summary' => {'activityCalories' => 200}}
        )
      allow(fitbit_double).to receive(:activities_on_date)
        .with(today).and_return(
          {'summary' => {'activityCalories' => 150}}
        )
      allow(@user).to receive(:fitbit) { fitbit_double }
      @calorie_log = CalorieLog.create(
        user: @user, calories: 100, fitbit_date: yesterday
      )
      CalorieFetcher.new(@user).fetch
    end
    subject(:new_calories) { CalorieLog.where('id > ?', @calorie_log.id) }

    context 'logging gap calories & new days' do
      it { expect(new_calories.count).to eq(2) }
      it { expect(new_calories[0].calories).to eq(100) }
      it { expect(new_calories[1].calories).to eq(150) }
    end
  end
end
