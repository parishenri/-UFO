class PaymentsController < ApplicationController
  before_action :set_order

  def new
    @order = Order.find(params[:order_id])
    if @order.dry_cleaning 
      @dry_cleaning_cost = 10
      @order.amount_cents = @order.amount_cents + 1200  
    elsif @order.dry_cleaning && @order.category == "Jacket"
      @dry_cleaning_cost = "£2000"
      @order.amount_cents = @order.amount_cents + 2000
    elsif @order.dry_cleaning && @order.category == 'Dress'
      @dry_cleaning_cost = "£3000"
      @order.amount_cents = @order.amount_cents + 3000
    end
    if @order.shipping
      @shipping_cost = 12
      @order.amount_cents = @order.amount_cents + 1200
    end
  end

def create
  customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail]
  )

  charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @order.amount_cents,
    description:  "Payment for item #{@order.item_sku} for order #{@order.id}",
    currency:     @order.amount.currency
  )

  @order.update(payment: charge.to_json, state: 'paid')
  redirect_to order_path(@order)

rescue Stripe::CardError => e
  flash[:alert] = e.message
  redirect_to new_order_payment_path(@order)
end

private

  def set_order
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
  end
end


