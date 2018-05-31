class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.item = Item.find(params[:item_id])
    @review.save
  end

  private

  def review_params
    params.require(:review).permit(:description)
  end
end