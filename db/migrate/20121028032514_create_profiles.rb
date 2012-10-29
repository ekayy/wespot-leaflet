class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.integer :user_id

    	t.string :username

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
