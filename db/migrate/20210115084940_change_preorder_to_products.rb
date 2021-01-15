class ChangePreorderToProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :preorder, :string
    add_column :products, :preorder, :date
  end
end
