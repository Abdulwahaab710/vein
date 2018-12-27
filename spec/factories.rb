# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "MyString" }
    phone { "MyString" }
    password_digest { "MyString" }
    confirm_token { "MyString" }
    phone_confirmed { false }
    is_donor { false }
    is_recipient { false }
    blood_type { nil }
    district { nil }
    city { nil }
  end
  factory :blood_compatibility do
    donator { nil }
    receiver { nil }
  end
  factory :blood_type do
    name { 'AB+' }
  end
  factory :district do
    name { 'Al mansoura' }
    city { nil }
  end
  factory :city do
    name { 'Aden' }
    area_code { 0o2 }
    country
  end

  factory :country do
    name { 'Yemen' }
    area_code { 967 }
  end
end
