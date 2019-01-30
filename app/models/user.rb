# frozen_string_literal: true

class User < ApplicationRecord
  before_validation(on: %i[create update]) { self.phone = phone.delete('_.()+-') if phone.present? }
  before_update :update_donor_status, if: :is_donor_changed?

  VALID_PHONE_NUMBER_REGEX = /\A(\d+)\z/i.freeze

  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true
  validates :confirm_token, uniqueness: true

  validates :password,
            presence: true,
            on: :create
  validates :password,
            confirmation: true

  validates :password_confirmation,
            presence: true,
            length: { minimum: 6 },
            if: ->(u) { !u.password.nil? }

  validate :user_is_donor_or_recipient?

  belongs_to :blood_type, optional: true
  belongs_to :district, optional: true
  belongs_to :city, optional: true
  belongs_to :donor_status, optional: true

  include Tokenable

  has_secure_password

  has_many :sessions, dependent: :destroy

  def donor?
    is_donor == true
  end

  def recipient?
    is_recipient == true
  end

  def confirmed?
    phone_confirmed == true
  end

  def generate_confirm_token
    generate_token
    update(phone_confirmed: false)
  end

  private

  def user_is_donor_or_recipient?
    errors.add(:base, 'User can be a donor or a recipient, not both') if donor_and_recipient?
  end

  def donor_and_recipient?
    [is_donor, is_recipient].compact.count(true) > 1
  end

  def update_donor_status
    self.donor_status = DonorStatus.find_by(status: 'Available') if is_donor
  end
end
