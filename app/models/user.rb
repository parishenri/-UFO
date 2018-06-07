class User < ApplicationRecord
  # validates :photo, presence: true
  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :bookings
  has_many :orders
  has_many :messages
  has_many :conversations
  has_many :reviews


  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def average_rating
    if reviews.count == 0
      0
    else 
      sum = 0
      counter = 0
      items.each do |item|
        item.reviews.each do |review|
          sum += review.rating
          counter += 1
        end
      end
      average = sum / counter 
      return average
    end
  end

end
