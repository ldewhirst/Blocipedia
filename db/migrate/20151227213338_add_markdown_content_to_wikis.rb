class AddMarkdownContentToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :text
  end
end
