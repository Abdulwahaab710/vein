# frozen_string_literal: true

class TwilioJob < ApplicationJob
  private

  def send_sms_message(phone_number, body)
    twilio_client.messages.create(from: ENV['TWILIO_PHONE_NUMBER'], to: phone_number, body: body)
  end

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  end
end
