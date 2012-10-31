class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
    	t.integer :user_id

    	t.string :business_name
      t.string :street
      t.string :city
      t.string :zip
      t.string :state
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
