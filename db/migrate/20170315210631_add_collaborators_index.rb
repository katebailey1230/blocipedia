class AddCollaboratorsIndex < ActiveRecord::Migration
  def change
    add_column :collaborators, :user_id, :integer
    add_column :collaborators, :wiki_id, :integer
  end
end
