class AddUserHoaToEvent < ActiveRecord::Migration
  def change
    add_column :events, :user_id, :integer
    add_column :events, :hoa_id, :integer
  end
end
