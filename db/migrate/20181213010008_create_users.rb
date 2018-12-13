class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, :null => false, default: ""
      t.integer :gender
      t.integer :height
      t.integer :figure
      t.integer :work
      t.integer :income
      t.integer :debt
      t.integer :hobby
      t.string :body
      t.datetime :birthday
      t.integer :divorced_number
      t.integer :children
      t.datetime :last_merried_start_time
      t.datetime :last_merried_last_time
      t.integer :remarried_desired_time
      t.string :divorced_reason
      t.string :what_learned_from_divorce
      t.string :adress
      t.integer :age
      t.integer :final_education
      t.string :message_for_opponent
      t.boolean :is_facebook_connected, default: false
      t.datetime :last_login_at
      t.string :authentication_token
      t.string :icon
      t.boolean :is_sms_verified, default: false
      t.string :firebase_token
      t.boolean :is_purchased, default: false

      t.datetime :deleted_at

      t.timestamps
    end
  end
end
