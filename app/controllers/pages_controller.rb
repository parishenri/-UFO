class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @items = Item.all
    @location = request.location.data['city']
  end

  def user_listing
    @items = current_user.items
    @user = current_user
    @bookings = @items.map(&:bookings).flatten

    @bookings = @bookings.select { |booking| booking.item_id == params[:item][:name].to_i } if params[:item] && params[:item][:name]
    @item = Item.new

    @user_items = Item.where(user: current_user)
  end

  def user_listing_edit
    @item = Item.find(params[:item_id])
  end

  def user_profile
    @user = User.find(params[:id])
  end
end
