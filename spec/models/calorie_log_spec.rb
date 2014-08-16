require 'rails_helper'

RSpec.describe CalorieLog, :type => :model do
  it { should belong_to(:user) }
  it { should have_one(:burrito) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:calories) }
  it { should validate_numericality_of(:calories).only_integer }
end
