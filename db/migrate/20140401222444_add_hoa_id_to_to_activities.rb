class AddHoaIdToToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :hoa_id, :integer
  end
end
