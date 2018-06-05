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

    any_field_from_form = params[:size] || params[:buying_price_cents] || params[:rental_price_cents] || params[:color]
    # both search in nav and filter in index
    if params[:query].present? && any_field_from_form
      items_searched = Item.global_search(params[:query])
      items_filtered = Item.filter(params)
      @items = items_searched & items_filtered
    # only search in nav
    elsif params[:start_date_search].present?
      start_date = Date.parse(params[:start_date_search].split("to").first)
      end_date = Date.parse(params[:start_date_search].split("to").last)
      @items = Item.filter_dates(start_date, end_date)
    elsif params[:query].present?
      @items = Item.global_search(params[:query])
    # only filters
    elsif any_field_from_form
      @items = Item.filter(params)
    # none
    else
      @items = Item.includes(:user).where(user_id: near_items.map(&:id))
    end

    @markers = @items.map do |item|
      {
        lat: item.user.latitude,
        lng: item.user.longitude#,
      }
    end
    @markers.uniq!

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
    @conversation = Conversation.new
    @review = Review.new

    @order = Order.new
    @unavailable_dates = []
    @item.bookings.each do |booking|
      (booking.start_date..booking.end_date).each do |day|
        @unavailable_dates << { from: day, to: day }
      end
    end

    @markers = { lat: @user.latitude, lng: @user.longitude}


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
    params.require(:item).permit(:name, :description, :rental_price_cents, :buying_price_cents, :size, :availability, :rental_only, :photo, :color)
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
