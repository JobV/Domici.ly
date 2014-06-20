class AddAddressToHoa < ActiveRecord::Migration
  def change
    add_column :hoas, :address, :string
    add_column :hoas, :city, :string
    add_column :hoas, :postal_code, :string
    add_column :hoas, :kvk, :string
    add_column :hoas, :account_nr, :string
    add_column :hoas, :account_owner, :string
  end
end
