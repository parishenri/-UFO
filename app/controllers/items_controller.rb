class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :set_variables, only: [:new, :index]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @item = Item.new

    @location = request.location.data['city']

     if @location.empty?
        if params[:place].present?
          user_location = params[:place]
        else
          user_location = "London UK"
        end
     else
      if params[:place].present?
          user_location = params[:place]
        else
          user_location = [request.location.data['latitude'], request.location.data['longitude']]
        end
     end

     near_items = User.near(user_location, 15)

    @items = Item.includes(:user).where(user_id: near_items.map(&:id))

    if params[:query].present?
      @search = Item.global_search(params[:query])
      @items = @search.where(user_id: near_items.map(&:id))
    else
      @items = Item.includes(:user).where(user_id: near_items.map(&:id))
    end

    if params[:item]
      @items = @items.filter(item_params)
    end

    @markers = @items.map do |item|
      {
        lat: item.user.latitude,
        lng: item.user.longitude#,
      }
    end

    respond_to do |format|
      format.html { render 'items/index' }
      format.js
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
    redirect_to item_path(@item)
  end

  def show
    @user = @item.user
    @booking = Booking.new
    @order = Order.new
    @booking_dates = []
    @item.bookings.each do |booking|
      @booking_dates << { from: booking.start_date, to: booking.end_date }
    end


    @markers = [@user].map do |u|
      {
        lat: u.latitude,
        lng: u.longitude#,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end

  def destroy
    @item.destroy
    redirect_to user_listing_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :rental_price, :buying_price, :size, :availability, :rental_only, :photo, :color)
  end

  def set_variables
    @prices = ["0-20", "21-100", "100-1000"]
    @sizes = ["xs", "s", "m", "l", "xl"]
    @colors = ["red", "green", "blue", "black", "white", "yellow", "pink"]
  end
end
