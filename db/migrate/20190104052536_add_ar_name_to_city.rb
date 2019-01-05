class AddArNameToCity < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :ar_name, :string
  end
end
