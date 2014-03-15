class AddUserIdHoaIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :hoa_id, :integer
  end
end
