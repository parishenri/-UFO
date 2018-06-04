class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :reviews
  validates :start_date, presence: true
  validates :end_date, presence: true


  def counter=(number)
    @counter = number
  end

  def counter
    @counter
  end

  def days_range
    (end_date - start_date).to_i
  end
end
