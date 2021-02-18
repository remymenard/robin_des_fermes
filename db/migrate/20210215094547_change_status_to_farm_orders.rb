class ChangeStatusToFarmOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :farm_orders, :status, :string
    add_column :farm_orders, :status, :string, default: "En préparation"
  end
end
