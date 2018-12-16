# frozen_string_literal: true

class District < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :city }

  belongs_to :city
end
