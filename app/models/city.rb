# frozen_string_literal: true

class City < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :country }

  belongs_to :country
end
