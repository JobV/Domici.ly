class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :users, [:invited_by_id, :invited_by_type]
    add_index :users, :hoa_id
    add_index :alerts, :user_id
    add_index :alerts, :assignee_id
    add_index :alerts, :hoa_id
    add_index :comments, :hoa_id
    add_index :events, :user_id
    add_index :events, :hoa_id
    add_index :participations, :user_id
    add_index :participations, :event_id
    add_index :posts, :user_id
    add_index :posts, :hoa_id
  end
end
