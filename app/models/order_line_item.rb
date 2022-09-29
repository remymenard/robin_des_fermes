class OrderLineItem < ApplicationRecord
  before_create :compute_total_price

  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :farm_order

  validates :product, presence: true
  validates :quantity, presence: true

  monetize :total_price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  def increment_quantity(qty)
    self.quantity += qty
    compute_total_price
  end

  def decrement_quantity
    if self.quantity > 0
      self.quantity -= 1
      compute_total_price
    end
  end

  def compute_total_price
    self.total_price = self.quantity * product.price
  end
end
