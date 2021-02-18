class AddCommentsToFarmOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :farm_orders, :comment, :text
  end
end
