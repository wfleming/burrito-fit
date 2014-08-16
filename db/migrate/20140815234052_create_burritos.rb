class CreateBurritos < ActiveRecord::Migration
  def change
    create_table :burritos do |t|
      t.references :user
      t.references :calorie_log
      t.timestamps
    end
  end
end
