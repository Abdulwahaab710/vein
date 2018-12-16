# frozen_string_literal: true

FactoryBot.define do
  factory :district do
    name { "MyString" }
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
