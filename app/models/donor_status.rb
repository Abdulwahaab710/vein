# frozen_string_literal: true

class DonorStatus < ApplicationRecord
  validates :status, presence: true, uniqueness: true

  has_many :users
end
