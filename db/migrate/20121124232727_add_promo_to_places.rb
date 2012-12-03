class AddPromoToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :promo, :text
  end
end
