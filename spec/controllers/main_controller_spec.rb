require 'rails_helper'

RSpec.describe MainController, :type => :controller do
  render_views

  describe 'index (homepage)' do
    context 'when logged in' do
      before do
        @user = User.new(
          oauth_token: OauthToken.new( extra_info: {'name' => @name} )
        )
        allow(subject).to receive(:current_user) { @user }

        get :index
       end
      it { is_expected.to respond_with 200 }
    end

    context 'when not logged in' do
      before { get :index }
      it { is_expected.to respond_with 200 }
    end
  end
end
