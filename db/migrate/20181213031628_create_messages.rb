class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :user_id, :limit => 8
      t.integer :chat_room_id, :limit => 8
      t.string :message_type, :null => false, default: "Text"
      t.string :text
      t.string :attachment_url
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
