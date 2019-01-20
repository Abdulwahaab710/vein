# frozen_string_literal: true

class BloodType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :donors, through: :donors_id

  def can_receive_from
    BloodCompatibility.where(receiver_id: self.id).map(&:donator)
  end

  def can_donate_to
    BloodCompatibility.where(donator_id: self.id).map(&:receiver)
  end
end
