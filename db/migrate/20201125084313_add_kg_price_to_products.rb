class AddKgPriceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :kg_price, :integer
  end
end
