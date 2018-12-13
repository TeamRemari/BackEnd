class CreateFootPrints < ActiveRecord::Migration[5.2]
  def change
    create_table :foot_prints do |t|
      t.integer :user_id, :limit => 8
      t.integer :to_user_id, :limit => 8
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
