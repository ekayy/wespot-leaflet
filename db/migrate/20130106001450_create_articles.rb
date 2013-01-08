class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :place_id
      t.string :url
      t.string :title
      t.string :snippet
      t.string :image

      t.timestamps
    end
  end
end
