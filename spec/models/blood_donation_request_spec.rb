# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BloodDonationRequest, type: :model do
  context 'when creating a blood donation request' do
    let(:user) { FactoryBot.create(:user) }

    it 'is valid with valid attributes' do
      expect(BloodDonationRequest.new(user: user, status: 'Matching in progress')).to be_valid
    end

    it 'is invalid without a user' do
      expect(BloodDonationRequest.new(status: 'Matching in progress')).not_to be_valid
    end

    it 'is invalid without a status' do
      expect(BloodDonationRequest.new(user: user)).not_to be_valid
    end

    it 'is invalid with invalid status' do
      expect(BloodDonationRequest.new(status: 'Invalid status')).not_to be_valid
    end
  end
end
