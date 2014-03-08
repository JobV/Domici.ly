class CreateBoardMembers < ActiveRecord::Migration
  def change
    create_join_table :hoas, :users, table_name: :board_members do |t|
      t.integer :hoa_id
      t.integer :user_id
    end
  end
end
