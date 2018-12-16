# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  let(:country) { FactoryBot.create(:country) }

  context 'When creating a city' do
    it 'is valid with valid attributes' do
      expect(City.new(name: 'Aden', area_code: 0o2, country: country)).to be_valid
    end

    it 'is invalid without a name' do
      expect(City.new(area_code: 0o2, country: country)).to be_invalid
    end

    it 'is invalid without a country' do
      expect(City.new(name: 'Aden', area_code: 0o2)).to be_invalid
    end

    it 'is valid without an area_code' do
      expect(City.new(name: 'Aden', country: country)).to be_valid
    end

    it 'enforces uniqueness city name for a country' do
      City.create(name: 'Aden', area_code: 0o2, country: country)
      expect(City.new(name: 'Aden', area_code: 0o2, country: country)).to be_invalid
    end

    it 'belongs to a country' do
      city = City.create(name: 'Aden', area_code: 0o2, country: country)
      expect(city.country).to eq(country)
    end
  end
end
