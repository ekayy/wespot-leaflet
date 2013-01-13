class AddInfoToPlaces < ActiveRecord::Migration
  def change
    change_table :places do |t|
      t.string :yelp_id
      t.string :yelp_url
      t.decimal :rating
      t.string :rating_img_url
      t.integer :review_count
      t.string :cost_scale
      t.string :website_url
      t.string :instagram_id
    end
  end
end
