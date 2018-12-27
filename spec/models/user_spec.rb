# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:city) { FactoryBot.create(:city) }
  let(:district) { FactoryBot.create(:district, city: city) }
  let(:blood_type) { FactoryBot.create(:blood_type) }

  context 'when creating a user' do
    it 'is valid with valid attributes' do
      expect(
        User.new(
          name: 'Abdulwahaab Ahmed', phone: '123456789',
          password: 'password123', password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city
        )
      ).to be_valid
    end

    it 'is invalid without a name' do
      expect(
        User.new(
          phone: '123456789',
          password: 'password123', password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city
        )
      ).to be_invalid
    end

    it 'is invalid without a phone' do
      expect(
        User.new(
          name: 'Abdulwahaab Ahmed', phone: nil,
          password: 'password123', password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city
        )
      ).to be_invalid
    end

    it 'is invalid without a password' do
      expect(
        User.new(
          name: 'Abdulwahaab Ahmed', phone: '123456789',
          password: nil, password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city
        )
      ).to be_invalid
    end

    it 'is invalid without password_confirmation' do
      expect(
        User.new(
          name: 'Abdulwahaab Ahmed', phone: '123456789',
          password: 'password123', password_confirmation: nil,
          blood_type: blood_type,
          district: district,
          city: city
        )
      ).to be_invalid
    end

    it 'enforces uniqueness for phone' do
      User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456789', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city
      )
      expect(
        User.new(
          name: 'John Smith', phone: '123456788',
          password: 'password123', password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city
        )
      ).to be_valid
    end

    it 'enforces uniqueness for confirm_token' do
      User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456789', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city, confirm_token: '123456'
      )
      expect(
        User.new(
          name: 'John Smith', phone: '123456788',
          password: 'password123', password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city, confirm_token: '123456'
        )
      ).to be_invalid

      expect(
        User.new(
          name: 'John Smith', phone: '123456788',
          password: 'password123', password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city, confirm_token: '123457'
        )
      ).to be_valid
    end
  end

  context 'when updating the user' do
    let(:user) do
      User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456789', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city, confirm_token: '123456'
      )
    end

    it 'enforces password_confirmation presence when the password is changed' do
      expect(user.update(password: 'new_password')).to eq(false)
      expect(user.update(password: 'new_password', password_confirmation: 'new_password')).to eq(true)
    end
  end
end
