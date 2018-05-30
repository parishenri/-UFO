class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :rental_price, presence: true
  validates :size, presence: true
  validates :photo, presence: true
  validates :color, presence: true

  mount_uploader :photo, PhotoUploader
  monetize :rental_price_cents
  monetize :buying_price_cents
  include PgSearch


  pg_search_scope :global_search,
    against: [ :name, :description ],
    using: {
    tsearch: { prefix: true }
    }

  def self.filter(args)
    size = args[:size] if args[:size].present?
    color = args[:color] if args[:color].present?

    if args[:rental_price].present?
      rental_price = args[:rental_price]
      arr = rental_price.split("..")
      rental_range = arr[0].to_i..arr[1].to_i
    end

    if args[:buying_price].present?
      buying_price = args[:buying_price]
      arr2 = buying_price.split("..")
      buying_range = arr2[0].to_i..arr2[1].to_i
    end

    return where(size: size, rental_price: rental_range, buying_price: buying_range, color: color) if size && rental_price && buying_price && color
    return where(size: size, rental_price: rental_range, buying_price: buying_range) if size && rental_price && buying_price
    return where(size: size, rental_price: rental_range, color: color) if size && rental_price && color
    return where(size: size, buying_price: buying_range, color: color) if size && buying_price && color
    return where(size: size, rental_price: rental_range, buying_price: buying_range) if size && rental_price && buying_price
    return where(size: size, rental_price: rental_range, buying_price: buying_range) if size && rental_price && buying_price
    return where(size: size, rental_price: rental_range) if size && rental_price
    return where(size: size, buying_price: buying_range) if size && buying_price
    return where(rental_price: rental_range, buying_price: buying_range, color: color) if color && rental_price && buying_price
    return where(rental_price: rental_range, buying_price: buying_range) if rental_price && buying_price
    return where(rental_price: rental_range, buying_price: buying_range, color: color) if rental_price && buying_price && color
    return where(rental_price: rental_range, color: color) if rental_price && color
    return where(buying_price: buying_range, color: color) if color && buying_price
    return where(rental_price: rental_range) if rental_price
    return where(buying_price: buying_range) if buying_price
    return where(size: size) if size
    return where(color: color) if color
    return all
  end

end
