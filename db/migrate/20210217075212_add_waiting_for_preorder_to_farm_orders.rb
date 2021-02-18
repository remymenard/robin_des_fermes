class AddWaitingForPreorderToFarmOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :farm_orders, :waiting_for_preorder_at, :datetime
  end
end
