class ApplicationMailer < ActionMailer::Base
  default from: ENV["DEFAULT_EMAIL"]
  layout 'mailer'

  rescue_from Postmark::InactiveRecipientError, with: :reactivate_and_retry

  private

  def postmark_client
    ::Postmark::ApiClient.new(ActionMailer::Base.postmark_settings[:api_token],
                              ActionMailer::Base.postmark_settings.except(:api_token))
  end

  def reactivate_and_retry(error)
    Rails.logger.info("Error when sending #{message} to #{error.recipients.join(', ')}")
    Rails.logger.info(error)

    error.recipients.each do |recipient|
      bounce = postmark_client.bounces(emailFilter: recipient).first
      next unless bounce
      postmark_client.activate_bounce(bounce[:id])
    end

    # Try again immediately
    message.deliver
  end
end
