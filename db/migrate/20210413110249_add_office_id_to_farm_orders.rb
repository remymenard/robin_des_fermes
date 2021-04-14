class AddOfficeIdToFarmOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :farm_orders, :farm_office, foreign_key: true
  end
end
