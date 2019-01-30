# frozen_string_literal: true

FactoryBot.define do
  factory :donor_status do
    status { 'Available' }
    available { false }
  end

  factory :blood_donation_request do
    user { nil }
    status { 'Matching in progress' }
  end

  factory :session do
    user
    ip_address { '127.0.0.1' }
    user_agent { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.2 Safari/605.1.15' }
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
