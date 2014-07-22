class AddHoaIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :hoa_id, :integer
  end
  add_foreign_key(:attachments, :hoa, dependent: :delete)
end
