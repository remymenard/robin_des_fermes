class AddDeliveryDelayToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :delivery_delay, :integer
  end
end
