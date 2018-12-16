# frozen_string_literal: true

require 'rails_helper'

RSpec.describe District, type: :model do
  let(:city) { FactoryBot.create(:city) }
  context 'When creating a district' do
    it 'is valid with valid attributes' do
      expect(District.new(name: 'Al mansoura', city: city)).to be_valid
    end

    it 'is invalid without a name' do
      expect(District.new(city: city)).to be_invalid
    end

    it 'is invalid without a city' do
      expect(District.new(name: 'Al mansoura')).to be_invalid
    end

    it 'belongs to a city' do
      district = District.new(name: 'Al mansoura', city: city)
      expect(district.city).to eq(city)
    end
  end
end
