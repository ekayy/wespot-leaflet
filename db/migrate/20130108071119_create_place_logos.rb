class CreatePlaceLogos < ActiveRecord::Migration
  def change
    create_table :place_logos do |t|
      t.integer :place_id
      t.integer :logo_id

      t.timestamps
    end

    add_index :place_logos, [:place_id, :logo_id]
  end
end
