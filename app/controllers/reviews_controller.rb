class ReviewsController < ApplicationController
  before_action :set_item

  def index
    @reviews = @item.reviews
    @review = Review.new
  end


  def create
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews

    @review = Review.new(review_params)
    @review.item = @item
    @review.user = current_user
    if @review.save
      respond_to do |format|
        format.html { redirect_to item_reviews_path(@item) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'reviews/show' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.delete
    redirect_to item_reviews_path
  end

  #   if @review.save
  #     redirect_to item_reviews_path
  #   else
  #     @reviews = @item.reviews
  #     render :index
  #   end
  # end


  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end