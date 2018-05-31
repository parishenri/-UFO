class DropMailerConversations < ActiveRecord::Migration[5.2]
  def change
    drop_table :mailboxer_conversation_opt_outs, force: :cascade
    drop_table :mailboxer_conversations, force: :cascade
    drop_table :mailboxer_notifications, force: :cascade
    drop_table :mailboxer_receipts, force: :cascade
  end
end
