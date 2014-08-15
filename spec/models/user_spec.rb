require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_one(:oauth_token) }
  it { should have_many(:calorie_logs) }

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
    it 'should construct a new Client, but only once' do
      expect(Fitgem::Client).to receive(:new).with(
        consumer_key: Rails.application.secrets.fitbit_key,
        consumer_secret: Rails.application.secrets.fitbit_secret,
        token: 'token',
        secret: 'secret'
      ).once.and_call_original

      client = @user.fitbit
      expect(@user.fitbit).to eq(client)
    end
  end
end
