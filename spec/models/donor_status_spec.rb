# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DonorStatus, type: :model do
  context 'when creating a donor status' do
    it 'is valid with valid attributes' do
      expect(DonorStatus.new(status: 'Available', available: true)).to be_valid
    end

    it 'is invalid without a status' do
      expect(DonorStatus.new(available: true)).not_to be_valid
    end

    it 'is invalid with an invalid status' do
      expect(DonorStatus.new(status: 'Invalid status')).not_to be_valid
    end
  end
end
