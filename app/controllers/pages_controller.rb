class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @items = Item.all
    @location = request.location.data['city']
  end

  def user_listing
    @items = Item.all
    @user = current_user
    @bookings = current_user.bookings

    @items_listing = Item.where(user_id: current_user).to_a
    @available_items = []
    @pending_items = []
    @accepted_items = []
    @pendingandbooked = []
    @bookings_listing = Booking.all
    # there is not a booking across all users
    if (@bookings_listing.length == 0)
      @items_listing.each do |item|
        @available_items.push(item)
      end
    else
      @bookings_listing.each do |booking|
        @items_listing.each do |item|
          #if its included in any array don`t push it in again
          if (@available_items.include?(item) == false && @pending_items.include?(item) == false && @accepted_items.include?(item) == false && @pendingandbooked.include?(item) == false)
            if (booking.item_id != item.id)
                @available_items.push(item)
            else
              # there are bookings_listing
              if (booking.status == "pending")
                @pending_items.push(item)
              elsif (booking.status == "accepted")
                @accepted_items.push(item)
              elsif (booking.status == "pending & booked")
                @pendingandbooked.push(item)
              end
            end
          end
        end
      end
    end
  end

  def user_profile
    @user = User.find(params[:id])
  end
end
