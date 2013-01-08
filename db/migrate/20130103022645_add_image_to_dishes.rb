class AddImageToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :image, :string
    add_column :dishes, :description, :text
  end
end
