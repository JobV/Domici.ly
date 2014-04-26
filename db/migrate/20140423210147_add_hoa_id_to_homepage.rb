class AddHoaIdToHomepage < ActiveRecord::Migration
  def change
    add_column :homepages, :hoa_id, :integer
    add_index :homepages, :hoa_id
  end
end
