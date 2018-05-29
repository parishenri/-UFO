class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :name, presence: true
  validates :description, presence: true
  validates :rental_price, presence: true
  validates :size, presence: true
  validates :photo, presence: true
  mount_uploader :photo, PhotoUploader
  include PgSearch


  pg_search_scope :global_search,
    against: [ :name, :description ],
    using: {
    tsearch: { prefix: true }
    }

  def self.filter(args)
    size = args[:size] if args[:size].present?
    rental_price = args[:rental_price] if args[:rental_price].present?
    buying_price = args[:buying_price] if args[:buying_price].present?

    return where(size: size, rental_price: rental_price, buying_price: buying_price) if size && rental_price && buying_price
    return where(size: size, rental_price: rental_price) if size && rental_price
    return where(size: size, buying_price: buying_price) if size && buying_price
    return where(rental_price: rental_price, buying_price: buying_price) if rental_price && buying_price
    return where(size: size) if size
    return where(rental_price: rental_price) if rental_price
    return where(buying_price: buying_price) if buying_price
    return all
  end

end
