class AddTotalWeightToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :total_weight, :string
  end
end
