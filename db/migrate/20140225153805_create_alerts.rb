class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :title
      t.text :body
      t.string :severity

      t.timestamps
    end
  end
end
