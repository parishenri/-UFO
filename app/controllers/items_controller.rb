class ItemsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :set_variables, only: [:new, :index, :edit]
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

    # for when you first get to index page
    @dates_for_search = []

    if params[:size] || params[:buying_price_cents] || params[:rental_price_cents] || params[:color]
      @items = @items.filter(form_tag_params)
      if params[:start_date].present? && params[:end_date].present?
        @items = Item.filter_dates(@items, params[:start_date], params[:end_date])
      end
    end

    if @items == []
    else
      @markers = @items.map do |item|
        {
          lat: item.user.latitude,
          lng: item.user.longitude#,
        }
      end
      @markers.uniq!
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
    @item_date = []
    @item_date << { from: @item.available_start_date, to: @item.available_end_date }
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
    @conversation = Conversation.new
    @review = Review.new

    @order = Order.new
    @booking_dates = []
    @available_dates = []
    @unavailable_dates = []
    (@item.available_start_date..@item.available_end_date).each do |day|
      @available_dates << { from: day, to: day }
    end
    @item.bookings.each do |booking|
      (booking.start_date..booking.end_date).each do |day|
        @unavailable_dates << { from: day, to: day }
      end
    end

    @unavailable_dates.each do |day_hash|
      if @available_dates.include?(day_hash)
        @available_dates.delete(day_hash)
      end
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
    params.require(:item).permit(:name, :description, :rental_price, :buying_price, :size, :availability, :available_start_date, :available_end_date, :rental_only, :photo, :color)
  end

  def form_tag_params
     params.permit(:rental_price_cents, :buying_price_cents, :size, :color, :start_date, :end_date)
  end

  def set_variables
    @categories = ["Jacket", "Long Sleeve Shirt", "Shirt", "Dress"]
    @prices = ["0-20", "21-100", "100-1000"]
    @sizes = ["XS", "S", "M", "L", "XL"]
    @colors = ["Red", "Green", "Blue", "Black", "White", "Yellow", "Pink"]
  end


end
