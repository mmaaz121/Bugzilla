class AddUniqueIndexForAssign < ActiveRecord::Migration[7.0]
  def change
    add_index :assigns, [:user_id, :project_id], unique: true
  end
end
