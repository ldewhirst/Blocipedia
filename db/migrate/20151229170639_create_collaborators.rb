class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :user
      t.integer :wiki
      t.timestamps null: false
    end
  end
end
