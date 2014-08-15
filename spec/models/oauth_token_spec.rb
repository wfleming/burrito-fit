require 'rails_helper'

RSpec.describe OauthToken, :type => :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:token) }
  it { should validate_presence_of(:secret) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:provider) }
  it { should validate_uniqueness_of(:token).scoped_to(:provider) }
  it { should validate_uniqueness_of(:secret).scoped_to(:provider) }
end
