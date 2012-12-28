class AddFollowersCountToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :followers_count, :integer
  end
end
