class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.integer :place_id

      t.integer :day
      t.time :open_time
      t.time :close_time

      t.timestamps
    end
  end
end
