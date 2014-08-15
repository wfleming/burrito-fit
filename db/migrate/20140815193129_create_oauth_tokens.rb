class CreateOauthTokens < ActiveRecord::Migration
  def change
    enable_extension :hstore
    create_table :oauth_tokens do |t|
      t.references :user
      t.string :uid
      t.string :token
      t.string :secret
      t.string :provider
      t.hstore :extra_info
      t.timestamps
    end
  end
end
