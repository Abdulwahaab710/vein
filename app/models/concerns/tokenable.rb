# frozen_string_literal: true

module Tokenable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_token, unless: :confirmed?
  end

  protected

  def generate_token
    self.confirm_token = loop do
      random_token = generate_random_number
      break random_token unless self.class.exists?(confirm_token: random_token)
    end
  end

  def generate_random_number
    (SecureRandom.random_number(9e8) + 1e8).to_i
  end
end
