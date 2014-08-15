class CreateCalorieLogs < ActiveRecord::Migration
  def change
    create_table :calorie_logs do |t|
      t.references :user
      t.integer :calories
      t.timestamps
    end
  end
end
