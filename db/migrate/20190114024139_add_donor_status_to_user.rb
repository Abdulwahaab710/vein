class AddDonorStatusToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :donor_status, foreign_key: true
  end
end
