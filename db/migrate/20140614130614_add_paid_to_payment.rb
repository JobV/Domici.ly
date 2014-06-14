class AddPaidToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :paid, :boolean, default: false
    add_column :payments, :payment_id, :string
  end
end
