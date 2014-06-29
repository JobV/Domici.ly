class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :readable_id
      t.integer :user_id,       null: false
      t.string :readable_type,  null: false

      t.timestamps
    end
    add_index :readings, :user_id
    add_index :readings, [:readable_id, :readable_type]
  end
end