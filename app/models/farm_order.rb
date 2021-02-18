class FarmOrder < ApplicationRecord
  STATUSES_TAKEAWAY = ["in_preparation", "ready_for_withdrawal", "withdrawn", "paid_to_farmer", "canceled"]
  STATUSES_SHIPPING = ["in_preparation", "shipped",              "received",  "paid_to_farmer", "canceled"]

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

  validates :status, inclusion: { in: ["waiting", "preordered", "waiting_shipping", "shipped", "issue"] }

  before_create :set_confirm_shipped_token

  def compute_total_price
    self.price = order_line_items.empty? ? 0 : order_line_items.sum { |order_line_item| order_line_item.total_price }
    self.save
    self.price
  end

  def total_price_with_shipping
    price + shipping_price
  end

  def farm_in_close_zone?(zip_code)
    farm.regions.include?(zip_code)
  end

  def delivery_price(zip_code)
    farm_in_close_zone?(zip_code) ? ShippingPrice.express : ShippingPrice.standard
  end

  def total_items_count
    # Memoization
    @total_items_count ||= order_line_items.sum { |item| item.quantity }
  end

  def shipping_choice_made?
    takeaway_at_farm || standard_shipping || express_shipping
  end

  def shipping_status_options
    takeaway_at_farm? ? STATUSES_TAKEAWAY : STATUSES_SHIPPING
  end

  def preordered_products_max_shipping_starting_at
    # Memoization
    @preordered_products_max_shipping_starting_at ||= begin
      preorder_array = []

      order_line_items.each do |order_line_item|
        if order_line_item.product.available_for_preorder?
          preorder_array << order_line_item.product.preorder_shipping_starting_at
        end
      end

      preorder_array.max
    end
  end

  def with_preordered_products?
    preordered_products_max_shipping_starting_at.present?
  end

  def shipping_choice_name
    if takeaway_at_farm
      'Retrait à la ferme'
    elsif express_shipping
      'Distribution régionale'
    elsif standard_shipping
      'Expédition nationale'
    end
  end

  def update_delivery_choice(user_choice)
    case user_choice
    when 'takeaway'
      if farm.accepts_take_away
        update!(status: 'waiting', takeaway_at_farm: true, standard_shipping: false, express_shipping: false, shipping_price: FarmOrder::ShippingPrice.takeaway.price)
      end
    when 'delivery'
      if farm.accepts_delivery
        if farm.regions.include?(@zip_code)
          update!(status: 'waiting', takeaway_at_farm: false, standard_shipping: false, express_shipping: true, shipping_price: FarmOrder::ShippingPrice.express.price)
        else
          update!(status: 'waiting', takeaway_at_farm: false, standard_shipping: true, express_shipping: false, shipping_price: FarmOrder::ShippingPrice.standard.price)
        end
      end
    end
  end

  def ready_for_payment?
    !status.nil?
  end

  def contains_preorder_product?
    order_line_items.any? {|order_line_item| order_line_item.product.available_for_preorder?}
  end

  def compute_preorder_delivery_date
    available_date = Date.current
    order_line_items.each do |order_line_item|
      unless order_line_item.product.preorder.nil?
        available_date = order_line_item.product.preorder if order_line_item.product.preorder > available_date
      end
    end
    available_date
  end

  def set_confirm_shipped_token
    self.confirm_shipped_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(20)
      break token unless FarmOrder.where(confirm_shipped_token: token).exists?
    end
  end
end
