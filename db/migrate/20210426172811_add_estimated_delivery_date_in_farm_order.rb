class AddEstimatedDeliveryDateInFarmOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :farm_orders, :estimated_delivery_date, :datetime
  end
end
