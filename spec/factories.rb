# frozen_string_literal: true

FactoryBot.define do
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
