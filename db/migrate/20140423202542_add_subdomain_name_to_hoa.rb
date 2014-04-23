class AddSubdomainNameToHoa < ActiveRecord::Migration
  def change
    add_column :hoas, :subdomain_name, :string
    add_index :hoas, :subdomain_name, unique: true
  end
end
