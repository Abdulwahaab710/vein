# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BloodType, type: :model do
  context 'When creating a Blood type' do
    it 'is valid with a name' do
      expect(BloodType.new(name: 'O-')).to be_valid
    end

    it 'is invalid without a name' do
      expect(BloodType.new).to be_invalid
    end

    it 'enforcess uniqueness for name' do
      BloodType.create(name: 'AB+')
      expect(BloodType.new(name: 'AB+')).to be_invalid
    end
  end
end
