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
      user = User.create(
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
          city: city, confirm_token: user.confirm_token
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

    it 'generates confirmation token' do
      user = User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456789', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city, confirm_token: nil
      )
      expect(user.confirm_token).not_to eq(nil)
    end

    it 'enforces phone number to be numbers only' do
      expect(
        User.new(
          name: 'John Smith', phone: 'aaaa123456788',
          password: 'password123', password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city, confirm_token: nil
        )
      ).to be_invalid

      expect(
        User.new(
          name: 'John Smith', phone: '123456788',
          password: 'password123', password_confirmation: 'password123',
          blood_type: blood_type,
          district: district,
          city: city, confirm_token: nil
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

    it 'enforces uniqueness for phone' do
      User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456788', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city
      )
      expect(user.update(phone: '123456788')).to eq(false)
      expect(user.update(phone: '123456789')).to eq(true)
    end

    it 'enforces uniqueness for confirm_token' do
      user2 = User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456788', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city
      )
      expect(user.update(confirm_token: user2.confirm_token)).to eq(false)
      expect(user.update(confirm_token: '123457')).to eq(true)
    end

    it 'enforces for a user to be either a donor or a recipient' do
      user.update(is_donor: true)
      expect(user.update(is_recipient: true)).to eq(false)
      expect(user.update(is_donor: false, is_recipient: true)).to eq(true)
    end

    it 'enforces for a user phone number to be only numbers' do
      expect(user.update(phone: 'a123123123')).to eq(false)
    end
  end

  context 'when calling #donor?' do
    let(:user) do
      User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456789', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city, confirm_token: '123456'
      )
    end

    it 'returns true when is_donor is set to true' do
      user.update(is_donor: true)
      expect(user.donor?).to eq(true)
    end

    it 'returns false when is_donor is set to false' do
      user.update(is_donor: false)
      expect(user.donor?).to eq(false)
    end
  end

  context 'when calling #recipient?' do
    let(:user) do
      User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456789', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city, confirm_token: '123456'
      )
    end

    it 'returns true when is_recipient is set to true' do
      user.update(is_recipient: true)
      expect(user.recipient?).to eq(true)
    end

    it 'returns false when is_recipient is set to false' do
      user.update(is_recipient: false)
      expect(user.recipient?).to eq(false)
    end
  end

  context 'when calling #confirmed?' do
    let(:user) do
      User.create(
        name: 'Abdulwahaab Ahmed', phone: '123456789', password: 'password123',
        password_confirmation: 'password123', blood_type: blood_type,
        district: district, city: city, confirm_token: '123456'
      )
    end

    it 'returns true when phone_confirmed is set to true' do
      user.update(phone_confirmed: true)
      expect(user.confirmed?).to eq(true)
    end

    it 'returns false when phone_confirmed is set to false' do
      user.update(phone_confirmed: false)
      expect(user.confirmed?).to eq(false)
    end
  end
end
