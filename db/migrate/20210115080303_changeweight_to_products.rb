class ChangeweightToProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :weight, :string
    add_column :products, :minimum_weight, :string
  end
end
