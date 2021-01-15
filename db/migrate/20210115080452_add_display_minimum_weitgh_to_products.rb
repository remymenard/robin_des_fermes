class AddDisplayMinimumWeitghToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :display_minimum_weight, :boolean, default: false
  end
end
