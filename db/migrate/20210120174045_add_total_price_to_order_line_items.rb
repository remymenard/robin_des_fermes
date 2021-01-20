class AddTotalPriceToOrderLineItems < ActiveRecord::Migration[6.0]
  def change
    add_monetize :order_line_items, :total_price
  end
end
