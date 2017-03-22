class ChangeCollabIndexToFalse < ActiveRecord::Migration
  def change
    remove_index :collaborators, :user_id
  end
end
