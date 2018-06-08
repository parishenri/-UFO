class AddColumnsToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :sender, index: true
    add_reference :messages, :receiver, index: true
  end
end
