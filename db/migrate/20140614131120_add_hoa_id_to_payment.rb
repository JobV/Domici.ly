class AddHoaIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :hoa_id, :integer
  end
end
