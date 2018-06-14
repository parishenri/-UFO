class Review < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :content, presence: true
  validates :content, length: { minimum: 20, too_short: "%{count} characters is the minimum allowed" }
  validates :content, length: { maximum: 90, too_long: "%{count} characters is the maxmimum allowed" }
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: [0,1,2,3,4,5] }
end
