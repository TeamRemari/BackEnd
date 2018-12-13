class CreateFacebookAuths < ActiveRecord::Migration[5.2]
  def change
    create_table :facebook_auths do |t|
      t.integer :user_id, :limit => 8
      t.string :access_token
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
