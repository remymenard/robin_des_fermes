class RenamePreorderToPreorderAtOnProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :preorder, :preorder_shipping_starting_at
  end
end
