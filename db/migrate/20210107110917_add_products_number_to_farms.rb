class AddProductsNumberToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :products_number, :integer
  end
end
