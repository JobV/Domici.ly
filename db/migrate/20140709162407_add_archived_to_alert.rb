class AddArchivedToAlert < ActiveRecord::Migration
  def change
    add_column :alerts, :archived, :boolean, default: false
  end
end
