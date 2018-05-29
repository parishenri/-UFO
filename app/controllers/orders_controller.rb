class OrdersController < ApplicationController
	def create
		item = Item.find(params[:item_id])
		if params["type"] == "buying"
			order  = Order.create!(item_sku: item.sku, amount_cents: item.buying_price_cents, state: 'pending', user: current_user)
		else
			order  = Order.create!(item_sku: item.sku, amount_cents: item.rental_price_cents, state: 'pending', user: current_user)
		end
		

		redirect_to new_order_payment_path(order)
	end

	def show
	  @order = current_user.orders.where(state: 'paid').find(params[:id])
	end
end
