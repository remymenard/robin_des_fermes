class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'User', optional: true
  has_many :order_line_items, dependent: :destroy

  has_many :farm_orders, dependent: :destroy

  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  validates :status, inclusion: { in: ["paid", "waiting"] }

  DATATRANS_TRANSACTION_ORDER_STATUSES_MAPPING = {
    # status datatrans transaction => status order

    'settled'                      => 'paid',
    ''                             => 'waiting'
  }

  scope :waiting, -> { where(status: :waiting) }

  def compute_total_price
    self.price = farm_orders.empty? ? 0 : farm_orders.sum { |farm_order| farm_order.price + farm_order.shipping_price }
    self.save
    self.price
  end
end
