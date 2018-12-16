# frozen_string_literal: true

class Country < ApplicationRecord
  validates :name, :area_code, presence: true
  validates :name, uniqueness: true
end
