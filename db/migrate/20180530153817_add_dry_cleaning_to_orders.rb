class AddDryCleaningToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :dry_cleaning, :boolean
  end
end
