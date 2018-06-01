class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :show, :update, :destroy]
  before_action :set_item, except: [:index, :accept, :decline]
  before_action :set_user, only: :index

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
    @bookings = current_user.bookings
    @user_bookings = @bookings
    @user_bookings = @bookings.where(id: params[:booking][:item]) if params[:booking] && params[:booking][:item]
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @conversation = Conversation.new
    @message = Message.new(content: @booking.start_date)
    @booking.user = current_user
    @booking.status = "pending"
    @booking.item = Item.find(params[:item_id])
    @conversation.sender_id = current_user.id
    @conversation.receiver_id = @booking.item.user.id
    @conversation.booking = @booking
    @booking.save
    @conversation.save
    @message.user = current_user
    @message.conversation = @conversation
    @message.save

    flash[:notice] = 'Your request has been sent'
    redirect_to conversation_messages_path(@conversation)
  end

  def update
    @booking.update(booking_params)
    redirect_to item_booking_path(@item, @booking)
  end

  def destroy
    item = @booking.item
    @booking.destroy
    redirect_to user_bookings_path(current_user)
  end

  def accept
    booking = Conversation.find(params[:conversation_id]).booking
    booking.status = "accepted"
    booking.save
    redirect_back(fallback_location: root_path)
  end

  def decline
    booking = Conversation.find(params[:conversation_id]).booking
    booking.status = "declined"
    booking.save
    redirect_back(fallback_location: root_path)
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def booking_params
    params.require(:booking).permit(:item_id, :user_id, :start_date, :end_date)
  end

end
