class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :display_name
      t.string :key

      t.timestamps
    end
    add_index :categories, :key, :unique => true
  end
end
