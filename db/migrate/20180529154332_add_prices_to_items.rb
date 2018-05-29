class AddPricesToItems < ActiveRecord::Migration[5.2]
  def change
  	add_monetize :items, :rental_price, currency: { present: false }
  	add_monetize :items, :buying_price, currency: { present: false }

  end
end
