# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendConfirmationCodeJob, type: :job do
  include ActiveJob::TestHelper

  let(:user) { FactoryBot.create(:user) }
  let(:job) { SendConfirmationCodeJob.perform_later(user) }

  context 'when running the job' do
    it 'queues the job' do
      expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'sends an sms messages to the user' do
      SendConfirmationCodeJob.perform_now(user)
      expect(FakeSMS.messages.last[:to]).to eq(user.phone)
    end

    it 'sends the confirmation code to the user' do
      SendConfirmationCodeJob.perform_now(user)
      expect(FakeSMS.messages.last[:body]).to eq(t('confirmation_sms_message', confirm_token: user.confirm_token))
    end
  end
end
