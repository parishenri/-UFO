class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :influencer_status, :boolean, default: false
  end
end
