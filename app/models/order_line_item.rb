class OrderLineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product

  validates :product, presence: true
  validates :quantity, presence: true
end
