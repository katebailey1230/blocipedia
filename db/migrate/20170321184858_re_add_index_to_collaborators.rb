class ReAddIndexToCollaborators < ActiveRecord::Migration
  def change
    add_index :collaborators, :wiki_id, unique: false
  end
end
