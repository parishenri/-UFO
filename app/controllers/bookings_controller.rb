class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :show]

  def new
    @booking = Booking.new
  end

  def edit
    # see before action
  end

  def show
    # see before action
  end

  def index
    @bookings = Booking.all
  end

  def create
    @item = Item.create(booking_params)
    redirect_to bookings_show_path
  end

  def update
    @booking.update(booking_params)
    redirect_to bookings_show_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:item_id, :user_id, :start_date, :end_date)
  end

end
