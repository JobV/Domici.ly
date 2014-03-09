class AddHoaIdToAlert < ActiveRecord::Migration
  def change
    add_column :alerts, :hoa_id, :integer
  end
end
