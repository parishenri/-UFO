class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :bookings
  has_many :orders

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  acts_as_messageable

  def name
    "User #{:id}"
  end

  def mailboxer_email(object)
    nil
  end

end
