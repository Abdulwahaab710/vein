# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.integer :area_code

      t.timestamps
    end
    add_index :countries, :name, unique: true
  end
end
