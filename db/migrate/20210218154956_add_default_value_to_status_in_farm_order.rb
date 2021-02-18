class AddDefaultValueToStatusInFarmOrder < ActiveRecord::Migration[6.0]
  def change
    change_column_default(
      :farm_orders,
      :status,
      "waiting"
    )
  end
end
