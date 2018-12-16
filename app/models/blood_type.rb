# frozen_string_literal: true

class BloodType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
