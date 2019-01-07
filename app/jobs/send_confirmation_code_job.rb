# frozen_string_literal: true

class SendConfirmationCodeJob < TwilioJob
  queue_as :default

  def perform(user, _locale)
    send_sms_message(user.phone, I18n.t('confirmation_sms_message', confirm_token: user.confirm_token))
  end
end
