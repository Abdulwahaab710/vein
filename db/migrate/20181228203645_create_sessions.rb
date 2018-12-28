class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: true
      t.string :ip_address
      t.string :user_agent
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
