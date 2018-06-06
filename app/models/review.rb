class Review < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :content, presence: true
  validates_format_of :content, with: /^(?:\b\w+\b[\s\r\n]*){5,50}$/, message: "Please write a review of minimum 6 words", multiline: true
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: [0,1,2,3,4,5] }
end
