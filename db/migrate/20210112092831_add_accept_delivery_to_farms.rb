class AddAcceptDeliveryToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :accept_delivery, :boolean, default: false
  end
end
