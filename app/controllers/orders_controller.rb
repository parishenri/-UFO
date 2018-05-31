class OrdersController < ApplicationController
	def create
		item = Item.find(params[:item_id])
		params["dry_cleaning"].nil? ? @dry_cleaning = false : @dry_cleaning = true
		params["shipping"].nil? ? @shipping = false : @shipping = true
		if params["type"] == "buying"
			order  = Order.create!(item: item, item_sku: item.sku, amount_cents: item.buying_price_cents, state: 'pending', user: current_user, dry_cleaning: @dry_cleaning, shipping: @shipping)
		else
			order  = Order.create!(item: item, item_sku: item.sku, amount_cents: item.rental_price_cents, state: 'pending', user: current_user, dry_cleaning: @dry_cleaning, shipping: @shipping)
		end
		redirect_to new_order_payment_path(order)
	end

	def show
	  @order = current_user.orders.where(state: 'paid').find(params[:id])
	end
end
