class SessionsController < ApplicationController
  # Called by OmniAuth when auth succeeded
  def create
    render :text => auth_hash.inspect
  end

  # Called by OmniAuth when auth failed with a 'message' param
  def failure
    render :status => 500, :text => params[:message]
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
