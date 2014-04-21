class CreateSupportMessages < ActiveRecord::Migration
  def change
    create_table :support_messages do |t|
      t.text :body
      t.integer :user_id
      t.integer :hoa_id

      t.timestamps
    end
  end
end
