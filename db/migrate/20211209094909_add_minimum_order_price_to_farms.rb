class AddMinimumOrderPriceToFarms < ActiveRecord::Migration[6.0]
  def change
    add_monetize :farms, :minimum_order_price, amount: { null: true, default: 0 }
  end
end
