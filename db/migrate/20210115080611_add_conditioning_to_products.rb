class AddConditioningToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :conditioning, :string
  end
end
