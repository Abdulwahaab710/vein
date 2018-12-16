# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BloodCompatibility, type: :model do
  let(:blood_o_plus) { FactoryBot.create(:blood_type, name: 'O+') }
  let(:blood_a_b_plus) { FactoryBot.create(:blood_type, name: 'AB+') }

  context 'When creating a Blood compatibility' do
    it 'is valid with a donator and receiver blood type' do
      expect(BloodCompatibility.new(donator: blood_o_plus, receiver: blood_a_b_plus)).to be_valid
    end

    it 'is invalid without a donator' do
      expect(BloodCompatibility.new(donator: nil, receiver: blood_a_b_plus)).to be_invalid
    end

    it 'is invalid without a receiver' do
      expect(BloodCompatibility.new(donator: blood_o_plus, receiver: nil)).to be_invalid
    end

    it 'enforces uniqueness for blood type' do
      BloodCompatibility.create(donator: blood_o_plus, receiver: blood_a_b_plus)
      expect(BloodCompatibility.new(donator: blood_o_plus, receiver: blood_a_b_plus)).to be_invalid
      expect(BloodCompatibility.new(donator: blood_a_b_plus, receiver: blood_o_plus)).to be_valid
    end
  end
end
