class AddFreshToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :fresh, :boolean
  end
end
