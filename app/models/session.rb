# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user

  default_scope { where(is_deleted: nil) }

  validates :user_agent, :ip_address, presence: true

  def delete
    update(is_deleted: true)
  end
end
