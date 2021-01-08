class RemoveSellerIdFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :seller_id
  end
end
