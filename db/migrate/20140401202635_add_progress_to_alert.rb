class AddProgressToAlert < ActiveRecord::Migration
  def change
    add_column :alerts, :progress, :string, default: 'new'
  end
end
