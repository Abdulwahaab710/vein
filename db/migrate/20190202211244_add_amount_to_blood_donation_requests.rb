class AddAmountToBloodDonationRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :blood_donation_requests, :amount, :integer, default: 0
  end
end
