class AddSubdomainNameToHomepage < ActiveRecord::Migration
  def change
    add_column :homepages, :subdomain_name, :string
    add_index :homepages, :subdomain_name, unique: true
  end
end
