# frozen_string_literal: true

class User < ApplicationRecord
  before_validation(on: %i[create update]) { self.phone = phone.delete('_.()+-') if phone.present? }
  VALID_PHONE_NUMBER_REGEX = /\A(\d+)\z/i.freeze

  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true
  validates :confirm_token, uniqueness: true, if: ->(u) { !u.confirm_token.nil? }

  validates :password,
            presence: true,
            on: :create
  validates :password,
            confirmation: true

  validates :password_confirmation,
            presence: true,
            length: { minimum: 6 },
            if: ->(u) { !u.password.nil? }

  belongs_to :blood_type
  belongs_to :district
  belongs_to :city

  has_secure_password
end
