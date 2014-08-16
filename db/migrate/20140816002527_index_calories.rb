class IndexCalories < ActiveRecord::Migration
  def change
    add_index :calorie_logs, [:user_id, :calories]
  end
end
