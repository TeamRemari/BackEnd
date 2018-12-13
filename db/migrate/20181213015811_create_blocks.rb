class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.integer :user_id, :limit => 8
      t.integer :blockable_id, :limit => 8
      t.string :blockable_type
      t.datetime :deleted_at
      t.references :blockable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
