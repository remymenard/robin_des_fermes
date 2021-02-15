class AddShippingPriceToFarmOrders < ActiveRecord::Migration[6.0]
  def change
    add_monetize :farm_orders, :shipping_price
  end
end
