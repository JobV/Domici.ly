class AddAssigneeIdToAlert < ActiveRecord::Migration
  def change
    add_column :alerts, :assignee_id, :integer
  end
end
