class AddReadFlagToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :read_flag, :boolean, :null => false, default: false
  end
end
