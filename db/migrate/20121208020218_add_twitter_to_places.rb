class AddTwitterToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :twitter_id, :string
  end
end
