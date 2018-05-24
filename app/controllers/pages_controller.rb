class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @items = Item.all
    @location = request.location.data['city']
  end

  def dashboard
  end

  def user_profile
    @user = User.find(params[:id])
  end

  def user_listing
    @items = Item.where(user_id: current_user).to_a
    @available_items = []
    @pending_items = []
    @accepted_items = []
    @pendingandbooked = []
    @bookings = Booking.all
    # there is not a booking across all users
    if (@bookings.length == 0)
      @items.each do |item|
        @available_items.push(item)
      end
    else
      @bookings.each do |booking|
        @items.each do |item|
          #if its included in any array don`t push it in again
          if (@available_items.include?(item) == false && @pending_items.include?(item) == false && @accepted_items.include?(item) == false && @pendingandbooked.include?(item) == false)
            if (booking.item_id != item.id)
                @available_items.push(item)
            else
              # there are bookings
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
end
