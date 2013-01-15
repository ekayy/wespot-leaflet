class ChangeSnippetFormatInArticles < ActiveRecord::Migration
  def self.up
   change_column :articles, :snippet, :text
  end

  def self.down
   change_column :articles, :snippet, :string
  end
end