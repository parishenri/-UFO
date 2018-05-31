class ChangeConversations < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:conversations, :sender, index: true)
    remove_reference(:conversations, :receiver, index: true)
    add_column :conversations, :sender_id, :integer
    add_column :conversations, :receiver_id, :integer
  end
end
