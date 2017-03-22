class ChangeUniqueWikiIdToFalse < ActiveRecord::Migration
  def change
    remove_index :collaborators, :wiki_id
  end
end
