class AddPostOptionToHoa < ActiveRecord::Migration
  def change
    add_column :hoas, :allow_posts, :boolean, default: true
  end
end
