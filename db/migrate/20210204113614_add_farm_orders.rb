class AddFarmOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :farm_orders do |t|
      t.boolean :takeaway_at_farm
      t.boolean :standard_shipping
      t.boolean :express_shipping
      t.monetize :price
      t.datetime :waiting_for_shipping_at
      t.datetime :shipped_at
      t.datetime :issue_raised_at
      t.string :status

      t.references :order, null: false, foreign_key: true
      t.references :farm, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :order_line_items, :farm_order, foreign_key: true
  end
end
