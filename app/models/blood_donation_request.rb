# frozen_string_literal: true

class BloodDonationRequest < ApplicationRecord
  belongs_to :user

  validates :status, inclusion: { in: ['Matching in progress', 'Matched', 'Waitlisted', 'Withdrawn', 'Completed'] }
  validates :amount, :status, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }
end
