class AddIndexToCollaborators < ActiveRecord::Migration
  def change
    add_index :collaborators, :user_id, unique: true
    add_index :collaborators, :wiki_id, unique: true
  end
end
