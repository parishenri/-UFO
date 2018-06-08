class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @items = Item.all
    @location = request.location.data['city']
    @users = User.all
    # @most = Item.left_joins(:bookings).where.not("items.user_id = bookings.user_id").group(:id).order('COUNT(bookings.id) DESC')
    @most = Item.left_joins(:bookings).group(:id).order('COUNT(bookings.id) DESC')
    # @most_popular = @most.reject { |item| item.user == current_user }
  end

  def user_listing

    @items = current_user.items
    @user = current_user
    @bookings = @items.map(&:bookings).flatten

    @bookings = @bookings.select { |booking| booking.item_id == params[:item][:name].to_i } if params[:item] && params[:item][:name]
    @item = Item.new

    @user_items = Item.where(user: current_user)
  end
end
