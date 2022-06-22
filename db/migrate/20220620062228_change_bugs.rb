class ChangeBugs < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bugs, :user_id, true
  end
end
