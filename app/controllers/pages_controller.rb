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
    @items = Item.all
  end
end
