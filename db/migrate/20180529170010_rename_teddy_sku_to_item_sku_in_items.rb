class RenameTeddySkuToItemSkuInItems < ActiveRecord::Migration[5.2]
  def change
  	rename_column :orders, :teddy_sku, :item_sku
  end
end
