class AddAddressAndNrToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :house_number, :string
    add_column :users, :postal_code, :string
    add_column :users, :phone_number, :string
  end
end
