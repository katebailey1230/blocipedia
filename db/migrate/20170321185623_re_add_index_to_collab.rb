class ReAddIndexToCollab < ActiveRecord::Migration
  def change
    add_index :collaborators, :user_id, unique: false
  end
end
