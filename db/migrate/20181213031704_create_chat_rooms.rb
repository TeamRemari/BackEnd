class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.integer :user_id, :limit => 8
      t.integer :to_user_id, :limit => 8
      t.integer :unread_count

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
