class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :reviews
  validates :start_date, presence: true
  validates :end_date, presence: true

  def days_range
    (end_date - start_date).to_i
  end
end
