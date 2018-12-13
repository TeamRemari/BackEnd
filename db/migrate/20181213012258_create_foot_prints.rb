class CreateFootPrints < ActiveRecord::Migration[5.2]
  def change
    create_table :foot_prints do |t|
      t.integer :user_id
      t.integer :to_user_id

      t.timestamps
    end
  end
end
