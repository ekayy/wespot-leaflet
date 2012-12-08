class AddTwitterToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :twitterid, :string
  end
end
