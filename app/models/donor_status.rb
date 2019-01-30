# frozen_string_literal: true

class DonorStatus < ApplicationRecord
  validates :status, presence: true, uniqueness: true
  validates :status, inclusion: { in: ['Available', 'Matching in progress', 'Matched', 'Donated'] }

  has_many :users, dependent: :nullify
end
