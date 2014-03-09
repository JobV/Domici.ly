class AddHoaIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :hoa_id, :integer
  end
end
