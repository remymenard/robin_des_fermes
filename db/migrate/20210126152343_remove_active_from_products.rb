class RemoveActiveFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :active
  end
end
