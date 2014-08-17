class Api::V1::IosDeviceTokensController < ApplicationController
  before_filter :log_in_if_api_token_present

  def create
    device_token = params[:token]
    if !current_user.ios_device_tokens.find_by_token(device_token)
      current_user.ios_device_tokens.create!(token: device_token)
      render status: 201, nothing: true
    else
      render status: 204, nothing: true
    end
  end

  private

  def current_user
    @current_user
  end

  def log_in_if_api_token_present
    api_token = request.headers['HTTP_X_APITOKEN']
    if api_token && (user = User.find_by_api_token(api_token))
      @current_user = user
    end
  end
end
