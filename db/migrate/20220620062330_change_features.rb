class ChangeFeatures < ActiveRecord::Migration[7.0]
  def change
    change_column_null :features, :user_id, true
  end
end
