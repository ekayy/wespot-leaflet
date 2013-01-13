class AddImageUrlToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :image_url, :string
  end
end
