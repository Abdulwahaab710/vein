class AddArNameToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :ar_name, :string
  end
end
