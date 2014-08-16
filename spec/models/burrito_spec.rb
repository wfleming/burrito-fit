require 'rails_helper'

RSpec.describe Burrito, :type => :model do
  it { should belong_to(:user) }
  it { should belong_to(:calorie_log) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:calorie_log) }
end
