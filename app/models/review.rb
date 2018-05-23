class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  validates :description, presence: true
  validates_format_of :description, with: /^(?:\b\w+\b[\s\r\n]*){5,100}$/, multiline: true
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: [0,1,2,3,4,5] }
end
