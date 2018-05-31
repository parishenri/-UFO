class AddColumnsToConversation < ActiveRecord::Migration[5.2]
  def change
    add_reference :conversations, :booking, index: true
    add_reference :conversations, :sender, index: true
    add_reference :conversations, :receiver, index: true
  end
end
