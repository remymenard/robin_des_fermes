class FarmOrder < ApplicationRecord
  enum shipping_prices: {
    'takeaway' => 0,
    'express' => 15,
    'standard' => 30
  }

  belongs_to :order
  belongs_to :farm

  has_many :order_line_items

  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  monetize :shipping_price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  def compute_total_price
    self.price = order_line_items.empty? ? 0 : order_line_items.sum { |order_line_item| order_line_item.total_price }
    self.save
    self.price
  end
end
