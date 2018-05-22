class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :description, presence: true
  validates :rental_price, presence: true
  validates :size, presence: true
end
