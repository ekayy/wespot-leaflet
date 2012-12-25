class AddInfoToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :cost_scale, :string
    add_column :places, :website, :string
    add_column :places, :instagramid, :string
  end
end
