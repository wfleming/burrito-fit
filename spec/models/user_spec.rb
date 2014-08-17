require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_one(:oauth_token) }
  it { should have_many(:calorie_logs) }
  it { should have_many(:burritos) }
  it { should have_many(:ios_device_tokens) }

  describe '#to_s' do
    before do
      @name = "a_name"
      @user = User.new(
        oauth_token: OauthToken.new(
          extra_info: {'name' => @name}
        )
      )
    end

    it 'should pull name from fitbit oauth' do
      expect(@user.to_s).to eq(@name)
    end
  end

  describe '#fitbit' do
    before do
      @user = User.new(
        oauth_token: OauthToken.new(
          token: 'token',
          secret: 'secret'
        )
      )
    end

    it 'should construct a new Client with correct params' do
      expect(Fitgem::Client).to receive(:new).with(
        consumer_key: Rails.application.secrets.fitbit_key,
        consumer_secret: Rails.application.secrets.fitbit_secret,
        token: 'token',
        secret: 'secret'
      ).once.and_call_original

      @user.fitbit
    end

    it 'should use cached client for second call' do
      client = @user.fitbit
      expect(@user.fitbit).to be(client)
    end
  end

  describe '#fitbit_timezone' do
    before do
      @user = User.new(
        oauth_token: OauthToken.new(
          :extra_info => {'timezone' => 'America/New_York'}
        )
      )
    end
    subject { @user.fitbit_timezone }

    it 'should have the correct offset' do
      expect(subject.utc_offset).to eq(-18000)
    end
  end
end
