class RenameAcceptDeliveryColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :farms, :accept_delivery, :accepts_delivery
  end
end
