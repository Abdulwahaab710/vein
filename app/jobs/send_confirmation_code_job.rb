# frozen_string_literal: true

class SendConfirmationCodeJob < TwilioJob
  queue_as :default

  def perform(user)
    send_sms_message(user.phone, t('confirmation_sms_message', confirm_token: user.confirm_token))
  end
end
