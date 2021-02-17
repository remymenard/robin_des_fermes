class AddConfirmationShippingToken < ActiveRecord::Migration[6.0]
  def change
    add_column :farm_orders, :confirm_shipped_token, :string
  end
end
