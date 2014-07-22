class AddHoaIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :hoa_id, :integer
  end
end
