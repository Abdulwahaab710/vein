# frozen_string_literal: true

FactoryBot.define do
  factory :session do
    user { nil }
    ip_address { 'MyString' }
    user_agent { 'MyString' }
    is_deleted { false }
  end

  factory :user do
    name { 'Username' }
    phone { '123456789' }
    password { 'password123' }
    password_confirmation { 'password123' }
    confirm_token { '123456' }
    phone_confirmed { false }
    is_donor { false }
    is_recipient { false }
    blood_type
    district
    city
  end

  factory :blood_compatibility do
    donator { nil }
    receiver { nil }
  end

  factory :blood_type do
    name { 'AB+' }
  end

  factory :district do
    sequence(:name) { |n| "district-name-#{n}" }
    city
  end

  factory :city do
    sequence(:name) { |n| "city-name-#{n}" }
    area_code { 0o2 }
    country
  end

  factory :country do
    sequence(:name) { |n| "country-name-#{n}" }
    area_code { 967 }
  end
end
