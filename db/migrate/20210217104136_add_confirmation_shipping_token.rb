class AddConfirmationShippingToken < ActiveRecord::Migration[6.0]
  def change
    add_column :farm_orders, :confirmation_token, :string
  end
end
