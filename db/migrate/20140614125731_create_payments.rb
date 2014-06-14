class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount
      t.string :description
      t.string :order_id

      t.timestamps
    end
  end
end
