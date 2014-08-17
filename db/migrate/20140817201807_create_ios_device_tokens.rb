class CreateIosDeviceTokens < ActiveRecord::Migration
  def change
    create_table :ios_device_tokens do |t|
      t.references :user
      t.string :token

      t.timestamps
    end
  end
end
