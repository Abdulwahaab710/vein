class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :password_digest
      t.string :confirm_token
      t.boolean :phone_confirmed
      t.boolean :is_donor
      t.boolean :is_recipient
      t.references :blood_type, foreign_key: true
      t.references :district, foreign_key: true
      t.references :city, foreign_key: true

      t.timestamps
    end
    add_index :users, :phone, unique: true
    add_index :users, :confirm_token, unique: true
  end
end
