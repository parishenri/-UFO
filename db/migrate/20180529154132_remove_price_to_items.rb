class RemovePriceToItems < ActiveRecord::Migration[5.2]
  def change
  	remove_column :items, :price_cents
  	remove_column :items, :rental_price
  	remove_column :items, :buying_price
  end
end
