class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :contact, :howworks, :gettingstarted, :faq, :partners, :careers, :locations, :sustainability, :termsofservice, :ppolicy]

  def contact
  end

  def about
  end

  def howworks
  end

  def gettingstarted
  end

  def faq
  end

  def partners
  end

  def careers
  end

  def sustainability
  end

  def locations
  end

  def ppolicy
  end

  def termsofservice
  end

  def home
    @items = Item.all
    @location = request.location.data['city']
    @users = User.all
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
