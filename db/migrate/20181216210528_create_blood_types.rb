# frozen_string_literal: true

class CreateBloodTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :blood_types do |t|
      t.string :name

      t.timestamps
    end
    add_index :blood_types, :name, unique: true
  end
end
