class AddWeightToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :weight, :string
  end
end
