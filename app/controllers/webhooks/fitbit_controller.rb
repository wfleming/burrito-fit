class Webhooks::FitbitController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def subscription_update
    begin
      verify_token # for now just want to see if we do it correctly
      json = ActiveSupport::JSON.decode(body.request.read)
      json.each do |sub_notification|
        # sub ids == user id
        sub_id = sub_notification['subscriptionId'].to_i
        CalorieUpdateWorker.perform_async(sub_id)
      end
    rescue => ex
      logger.error(ex)
    end
    render status: 204, nothing: true
  end

  protected

  def verify_token
    provided_signature = headers['X-Fitbit-Signature']
    logger.debug('WEBHOOK header signature: ' + provided_signature)

    message = request.body.read
    logger.debug("WEBHOOK body: \n-------\n" + message + "\n---------------")

    # calculate our own signature to match
    key = "#{Rails.application.secrets.fitbit_secret}&"
    hmac = HMAC::SHA1.new(key)
    hmac.update(message)
    calculated_signature = Base64.encode64(hmac.digest)

    puts "calculated sig: #{calculated_signature}"
    (provided_signature == calculated_signature)
  end
end
