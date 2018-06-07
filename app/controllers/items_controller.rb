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
        @user_location = params[:place]
      else
        @user_location = "London UK"
      end
    else
      if params[:place].present?
        @user_location = params[:place]
      else
        @user_location = request.location.data['loc'].split(',')
      end
    end

    @show_clear = params[:controller] == 'items' && params[:action] == 'index'

    near_items = User.near(@user_location, 15)

    any_field_from_form = !params[:size].blank? || !params[:buying_price_cents].blank? || !params[:rental_price_cents].blank? || !params[:color].blank?
    date_param = params[:start_date_search].present? && params[:start_date_search].include?('to')
    # both search in nav and filter in index
    # binding.pry
    nearby_items = Item.includes(:user).where(user_id: near_items.map(&:id))

    if params[:query].present? && any_field_from_form && date_param
      items_searched = Item.global_search(params[:query])
      items_filtered = Item.filter(params)
      start_date = Date.parse(params[:start_date_search].split("to").first)
      end_date = Date.parse(params[:start_date_search].split("to").last)
      filtered_by_date = Item.filter_dates(start_date, end_date)
      @items = items_searched & items_filtered & filtered_by_date & nearby_items
    # only search in nav
    elsif params[:query].present? && any_field_from_form
      items_searched = Item.global_search(params[:query])
      items_filtered = Item.filter(params)
      @items = items_searched & items_filtered & nearby_items
    # only search in nav
    elsif date_param && any_field_from_form
      start_date = Date.parse(params[:start_date_search].split("to").first)
      end_date = Date.parse(params[:start_date_search].split("to").last)
      filtered_by_date = Item.filter_dates(start_date, end_date)
      items_filtered = Item.filter(params)
      @items = filtered_by_date & items_filtered & nearby_items
    elsif params[:query].present?
      @items = Item.global_search(params[:query]) & nearby_items
    # only filters
    elsif any_field_from_form
      @items = Item.filter(params) & nearby_items
    # none
    elsif date_param
      start_date = Date.parse(params[:start_date_search].split("to").first)
      end_date = Date.parse(params[:start_date_search].split("to").last)
      @items = Item.filter_dates(start_date, end_date) & nearby_items
    else
      @items = Item.includes(:user).where(user_id: near_items.map(&:id))
    end
    @markers = @items.map do |item|
      {
        lat: item.user.latitude,
        lng: item.user.longitude,
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

  def form_tag_params
     params.permit(:rental_price_cents, :buying_price_cents, :size, :color, :start_date, :end_date)
  end

  def set_variables
    @categories = ["Jacket", "Shirt", "Trousers", "Dress"]
    @prices = ["0-20", "21-100", "100-1000"]
    @sizes = ["XS", "S", "M", "L", "XL"]
    @colors = ["Red", "Green", "Blue", "Black", "White", "Yellow", "Pink"]
  end


end
