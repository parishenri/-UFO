class Order < ApplicationRecord
  belongs_to :user
  has_many :orders
  belongs_to :item
  
  monetize :amount_cents
end
