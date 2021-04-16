class FarmOrder < ApplicationRecord
  STATUSES_TAKEAWAY = ["peordered", "in_preparation", "ready_for_withdrawal", "withdrawn", "paid_to_farmer", "canceled"]
  STATUSES_SHIPPING = ["peordered", "in_preparation", "shipped",              "received",  "paid_to_farmer", "canceled"]

  belongs_to :order
  belongs_to :farm
  belongs_to :farm_office, optional: true

  has_many :order_line_items, dependent: :destroy
  has_many :products, through: :order_line_items
  has_one :buyer, through: :order

  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  monetize :shipping_price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  #validates :status, inclusion: { in: ["waiting", "preordered", "in_preparation", "shipped", "issue"] }

  before_create :set_confirm_shipped_token

  def delivery_date(zip_code)
    # if the order contains preorder products => calculates the delivery_date when the products will be available and not from today
    date = contains_preorder_product? ? waiting_for_shipping_at : Date.today
    if express_shipping
      correct_farm_office = farm.get_correct_farm_office(zip_code)
      days = %i[monday tuesday wednesday thursday friday saturday sunday]
      if date.wday == correct_farm_office.delivery_deadline_day && date.to_formatted_s(:time) < correct_farm_office.delivery_deadline_hour
        # if we are the day of the deadline and earlier than the hour => delivery_date = today + delays
        date + correct_farm_office.delivery_day.days
      else
        # if we are not the day of the deadline => delivery_date = next time that the days of the deadline occurs + delays
        date.next_occurring(days[correct_farm_office.delivery_deadline_day]) + correct_farm_office.delivery_day.days
      end
    elsif takeaway_at_farm || standard_shipping
      # if it's not a regional delivery
      date + farm.delivery_delay.days
    end
  end

  def number_of_fresh_product
    fresh_product = 0
    order_line_items.each do |order_line_item|
      fresh_product += 1 if order_line_item.product.fresh
    end
    fresh_product
  end

  def can_be_delivered?(zip_code)
    if !farm.is_in_close_zone?(zip_code)
      fresh_product = false
      order_line_items.each do |order_line_item|
        fresh_product = true if order_line_item.product.fresh
      end
      fresh_product.!
    else
      true
    end
  end

  def compute_total_price
    self.price = order_line_items.empty? ? 0 : order_line_items.sum { |order_line_item| order_line_item.total_price }
    self.save
    self.price
  end

  def total_price_with_shipping
    price + shipping_price
  end

  def delivery_price(zip_code)
    farm.is_in_close_zone?(zip_code) ? ShippingPrice.express : ShippingPrice.standard
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

  def shipping_choice_name
    if takeaway_at_farm
      'Retrait à la ferme'
    elsif express_shipping
      'Distribution régionale'
    elsif standard_shipping
      'Expédition nationale'
    end
  end

  def update_delivery_choice(user_choice, zip_code)
    case user_choice
    when 'takeaway'
      if farm.accepts_take_away
        update!(status: 'waiting', takeaway_at_farm: true, standard_shipping: false, express_shipping: false, shipping_price: FarmOrder::ShippingPrice.takeaway.price)
      end
    when 'delivery'
      if farm.accepts_delivery
        if farm.is_in_close_zone?(zip_code)
          update!(status: 'waiting', takeaway_at_farm: false, standard_shipping: false, express_shipping: true, shipping_price: FarmOrder::ShippingPrice.express.price, office: farm.get_correct_farm_office(zip_code))
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
      unless order_line_item.product.preorder_shipping_starting_at.nil?
        available_date = order_line_item.product.preorder_shipping_starting_at if order_line_item.product.preorder_shipping_starting_at > available_date
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
