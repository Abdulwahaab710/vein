# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, type: :model do
  context 'When creating a Country' do
    it 'is valid with valid attributes' do
      expect(Country.new(name: 'Yemen', area_code: 967)).to be_valid
    end

    it 'is invalid without a name' do
      expect(Country.new(area_code: 967)).to be_invalid
    end

    it 'is invalid without an area code' do
      expect(Country.new(name: 'Yemen')).to be_invalid
    end

    it 'enforces uniqueness for name' do
      Country.create(name: 'Yemen', area_code: 967)
      expect(Country.new(name: 'Yemen', area_code: 967)).to be_invalid
      expect(Country.new(name: 'Canada', area_code: 1)).to be_valid
    end

    it 'has many cities' do
      country = Country.create(name: 'Yemen', area_code: 967)
      city = City.create(name: 'Aden', area_code: 0o2, country: country)
      expect(Country.first.cities).to eq([city])
    end
  end
end
