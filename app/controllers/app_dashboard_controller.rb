class AppDashboardController < ApplicationController
  before_filter :verify_app_secret

  def show
    if !logged_in?
      render :logged_out_show
    else
      render :show
    end
  end

  def begin_sign_in
    session[:after_sign_in_path] = finished_sign_in_app_dashboard_path
    redirect_to '/auth/fitbit'
  end

  def finished_sign_in
  end

  private

  def verify_app_secret
    secret = headers['HTTP_X_APPSECRET']
    if secret != Rails.application.secrets.app_secret
      render status: 401, text: 'Not authorized'
      return false
    end
    true
  end
end
