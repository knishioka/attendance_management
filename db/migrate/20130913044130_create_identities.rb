class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :oauth_token, null: false

      t.timestamps
    end
    add_index :identities, [:uid, :provider], unique: true
  end
end
