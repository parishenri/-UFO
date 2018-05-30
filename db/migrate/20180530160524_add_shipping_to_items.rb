class AddShippingToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :shipping, :boolean
  end
end
