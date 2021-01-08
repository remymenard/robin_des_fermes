class ChangePriceFieldForProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :unit_price
    remove_column :products, :kg_price
    add_monetize :products, :price_per_unit
    add_monetize :products, :price

    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
