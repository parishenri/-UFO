class Item < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews,  dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :rental_price_cents, presence: true
  validates :size, presence: true, inclusion: { in: %w(XS S M L XL) }
  validates :photo, presence: true
  validates :color, presence: true, inclusion: { in: %w(Red Green Blue Black White Yellow Pink) }

  mount_uploader :photo, PhotoUploader
  monetize :rental_price_cents
  monetize :buying_price_cents
  include PgSearch


  pg_search_scope :global_search,
    against: [ :name, :description ],
    using: {
    tsearch: { prefix: true }
    }

  def average_rating
    if reviews.count == 0
       0
    else
      sum = 0
      reviews.each do |r|
        sum += r.rating
      end
      return sum / reviews.count
    end
  end

  def total_reviews
    reviews.count
  end


  def counter=(number)
    @counter = number
  end

  def counter
    @counter
  end

  def self.filter_dates(start_date, end_date)
    array = joins(:bookings).where.not("bookings.start_date >= ? AND bookings.start_date <= ? OR bookings.end_date >= ? AND bookings.end_date <= ? OR bookings.start_date <= ? AND bookings.end_date >= ?", start_date, end_date, start_date, end_date, start_date, end_date)
    final_array = array + Item.all.select { |item| item.bookings.empty? }
  end

  def self.filter(args)
    size = args[:size] if args[:size].present?
    color = args[:color] if args[:color].present?
    if args[:rental_price_cents].present?
      rental_price_cents = args[:rental_price_cents]
      arr = rental_price_cents.split("-")
      rental_range = ((arr[0].to_i*100)..(arr[1].to_i*100))
    end

    if args[:buying_price_cents].present?
      buying_price_cents = args[:buying_price_cents]
      arr2 = buying_price_cents.split("-")
      buying_range = ((arr2[0].to_i*100)..(arr2[1].to_i*100))
    end

    return where(size: size, rental_price_cents: rental_range, buying_price_cents: buying_range, color: color) if size && rental_price_cents && buying_price_cents && color
    return where(size: size, rental_price_cents: rental_range, buying_price_cents: buying_range) if size && rental_price_cents && buying_price_cents
    return where(size: size, rental_price_cents: rental_range, color: color) if size && rental_price_cents && color
    return where(size: size, buying_price_cents: buying_range, color: color) if size && buying_price_cents && color
    return where(size: size, rental_price_cents: rental_range, buying_price_cents: buying_range) if size && rental_price_cents && buying_price_cents
    return where(size: size, rental_price_cents: rental_range, buying_price_cents: buying_range) if size && rental_price_cents && buying_price_cents
    return where(size: size, rental_price_cents: rental_range) if size && rental_price_cents
    return where(size: size, buying_price_cents: buying_range) if size && buying_price_cents
    return where(rental_price_cents: rental_range, buying_price_cents: buying_range, color: color) if color && rental_price_cents && buying_price_cents
    return where(rental_price_cents: rental_range, buying_price_cents: buying_range) if rental_price_cents && buying_price_cents
    return where(rental_price_cents: rental_range, buying_price_cents: buying_range, color: color) if rental_price_cents && buying_price_cents && color
    return where(rental_price_cents: rental_range, color: color) if rental_price_cents && color
    return where(buying_price_cents: buying_range, color: color) if color && buying_price_cents
    return where(rental_price_cents: rental_range) if rental_price_cents
    return where(buying_price_cents: buying_range) if buying_price_cents
    return where("size iLIKE ?", size) if size
    return where(color: color) if color
    return all
  end

end
