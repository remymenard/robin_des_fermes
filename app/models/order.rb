class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'User', optional: true
  has_many :order_line_items, dependent: :destroy
  has_many :products, through: :order_line_items

  has_many :farm_orders
  has_many :farms, through: :farm_orders

  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  validates :status, inclusion: { in: ["paid", "failed", "waiting"] }

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

  def mimum_price_not_reached?
    farm_orders.any? {|farm_order| !farm_order.farm.minimum_order_reached?(farm_order) }
  end

  def get_first_farm_with_missing_price
    farm_order = farm_orders.find {|farm_order| !farm_order.farm.minimum_order_reached?(farm_order) }
    farm_order&.farm
  end

  def estimated_economy_delivery_price
    shipping_price_without_being_companion = 0
    farm_orders.each do |farm_order|
      shipping_price_without_being_companion += FarmOrder::ShippingPrice.standard_not_companion.price if farm_order.standard_shipping
      shipping_price_without_being_companion += FarmOrder::ShippingPrice.express_not_companion.price if farm_order.express_shipping
      shipping_price_without_being_companion += FarmOrder::ShippingPrice.takeaway.price if farm_order.takeaway_at_farm
    end
    shipping_price_without_being_companion - total_shipping_price
  end
end
