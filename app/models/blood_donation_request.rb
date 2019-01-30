# frozen_string_literal: true

class BloodDonationRequest < ApplicationRecord
  belongs_to :user

  validates :status, inclusion: { in: ['Matching in progress', 'Matched', 'Waitlisted', 'Withdrawn', 'Completed'] }
end
