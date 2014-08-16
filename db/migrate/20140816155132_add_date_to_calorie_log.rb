class AddDateToCalorieLog < ActiveRecord::Migration
  def change
    add_column :calorie_logs, :fitbit_date, :date
    add_index :calorie_logs, [:user_id, :fitbit_date, :calories]
  end
end
