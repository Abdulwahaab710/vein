# frozen_string_literal: true

class StaffUser < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :email, :confirm_token, uniqueness: true

  validates :password,
            presence: true,
            on: :create
  validates :password,
            confirmation: true

  validates :password_confirmation,
            presence: true,
            length: { minimum: 6 },
            if: ->(u) { !u.password.nil? }

  include Tokenable

  has_secure_password
end
