class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :user_id, :limit => 8
      t.integer :reportable_id, :limit => 8
      t.string :reportable_type
      t.datetime :deleted_at
      t.references :reportable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
