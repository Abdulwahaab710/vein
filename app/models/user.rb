# frozen_string_literal: true

class User < ApplicationRecord
  before_validation(on: %i[create update]) { self.phone = phone.delete('_.()+-') if phone.present? }
  VALID_PHONE_NUMBER_REGEX = /\A(\d+)\z/i.freeze

  validates :name, presence: true
  validates :phone,
            format: VALID_PHONE_NUMBER_REGEX,
            presence: true,
            uniqueness: true
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

  private

  def user_is_donor_or_recipient?
    errors.add(:base, 'User can be a donor or a recipient, not both') if donor_and_recipient?
  end

  def donor_and_recipient?
    [is_donor, is_recipient].compact.count(true) > 1
  end
end
