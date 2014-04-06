class AddHoaIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :hoa_id, :integer
  end
end
