class CreateDonorStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :donor_statuses do |t|
      t.string :status
      t.boolean :available

      t.timestamps
    end
    add_index :donor_statuses, :status, unique: true
  end
end
