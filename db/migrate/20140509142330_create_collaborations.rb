class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :user_id
      t.references :collaborable, polymorphic: true
      t.timestamps
    end
    add_index :collaborations, :user_id
    add_index :collaborations, [:collaborable_id, :collaborable_type]
  end
end
