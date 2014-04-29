class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :body
      t.integer :hoa_id
      t.integer :user_id
      t.string :target_group

      t.timestamps
    end
  end
end
