class RemoveAvailableOnItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :available_start_date
    remove_column :items, :available_end_date
  end
end
