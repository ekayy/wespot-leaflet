class CreatePlacesCategories < ActiveRecord::Migration
  def change
    create_table :places_categories, :id => false do |t|
      t.references :place, :category
    end

    add_index :places_categories, [:place_id, :category_id]
  end
end

