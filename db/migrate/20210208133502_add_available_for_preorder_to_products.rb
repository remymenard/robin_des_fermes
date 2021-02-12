class AddAvailableForPreorderToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :available_for_preorder, :boolean, default: false
  end
end
