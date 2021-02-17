class Order < ApplicationRecord
  attr_reader :DATATRANS_TRANSACTION_ORDER_STATUSES_MAPPING
  belongs_to :buyer, class_name: 'User', optional: true
  has_many :order_line_items, dependent: :destroy

  has_many :farm_orders

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
    self.price = order_line_items.empty? ? 0 : order_line_items.sum { |order_line_item| order_line_item.total_price }
    self.save
    self.price
  end

  def total_price_with_shipping
    price + total_shipping_price
  end

  def total_shipping_price
    farm_orders.sum(&:shipping_price)
  end

  def all_shipping_choices_made?
    farm_orders.all? {|farm_order| farm_order.shipping_choice_made? }
  end
end
