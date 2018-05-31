class AddColumnsToMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :user, index: true
    add_column :messages, :content, :string
    add_reference :messages, :conversation, index: true
  end
end
