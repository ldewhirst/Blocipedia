class AddMarkdownContentToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :text, :markdown_content
  end
end
