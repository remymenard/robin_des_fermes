class FarmOrder < ApplicationRecord
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
end
