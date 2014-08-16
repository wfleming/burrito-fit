require 'rails_helper'
require 'timecop'

RSpec.describe CalorieFetcher do
  before do
    Timecop.freeze
    @user = User.new
  end
  after { Timecop.return }
  subject { CalorieFetcher.new(@user) }

  it { expect(subject.user).to eq(@user) }

  describe '#fetch' do
    before do
      fitbit_double = double(:fitbit)
      puts "stub first: #{1.day.ago.utc.midnight}"
      puts "stub second: #{Time.now.utc.midnight}"
      allow(fitbit_double).to receive(:activities_for_day)
        .with(1.day.ago.utc.midnight).and_return(
          {'summary' => {'activityCalories' => 200}}
        )
      allow(fitbit_double).to receive(:activities_for_day)
        .with(Time.now.utc.midnight).and_return(
          {'summary' => {'activityCalories' => 150}}
        )
      allow(@user).to receive(:fitbit) { fitbit_double }
      @calorie_log = CalorieLog.create(
        user: @user, calories: 100, created_at: 1.day.ago
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
