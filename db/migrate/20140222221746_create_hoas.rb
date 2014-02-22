class CreateHoas < ActiveRecord::Migration
  def change
    create_table :hoas do |t|
      t.string :name

      t.timestamps
    end
  end
end
