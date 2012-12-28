class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.integer :place_id
      t.string :name

      t.timestamps
    end
  end
end
