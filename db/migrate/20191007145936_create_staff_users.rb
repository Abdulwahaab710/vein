class CreateStaffUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :staff_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :confirmed_email
      t.string :confirm_token

      t.timestamps
    end
    add_index :staff_users, :email, unique: true
    add_index :staff_users, :confirm_token, unique: true
  end
end
