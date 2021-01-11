class OrderLineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product, presence: true
  validates :quantity, presence: true
end
