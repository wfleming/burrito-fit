require 'rails_helper'

RSpec.describe IosDeviceToken, :type => :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
end
