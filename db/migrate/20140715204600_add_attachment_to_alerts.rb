class AddAttachmentToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :attachment, :string
  end
end
