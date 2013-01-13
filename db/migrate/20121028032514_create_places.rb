class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
    	t.integer :user_id

    	t.string :business_name
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :city
      t.string :state_code
      t.string :postal_code
      t.string :country_code
      t.string :phone

      t.timestamps
    end
  end
end
