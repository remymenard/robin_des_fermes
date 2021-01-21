class AddPreorderToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :preorder, :string
  end
end
