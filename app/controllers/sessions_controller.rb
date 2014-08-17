class SessionsController < ApplicationController
  # Called by OmniAuth when auth succeeded
  def create
    existing_token = OauthToken.where(
      provider: auth_hash.provider,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret,
      uid: auth_hash.uid
    ).first

    if existing_token
      log_in(existing_token.user)
    else
      # delete any potentially expired tokens for same user
      old_tokens = OauthToken.where(
        :provider => auth_hash.provider,
        :uid => auth_hash.uid
      )
      user = old_tokens.first.try(:user) || User.create!
      old_tokens.destroy_all
      new_token = OauthToken.create!(
        user: user,
        provider: auth_hash.provider,
        token: auth_hash.credentials.token,
        secret: auth_hash.credentials.secret,
        uid: auth_hash.uid,
        extra_info: auth_hash.info
      )
      log_in(user)
      CreateFitbitSubscriptionWorker.perform_async(user.id)
    end

    redirect_to '/'
  end

  # Called by OmniAuth when auth failed with a 'message' param
  def failure
    render :status => 500, :text => params[:message]
  end

  def destroy
    log_out
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
