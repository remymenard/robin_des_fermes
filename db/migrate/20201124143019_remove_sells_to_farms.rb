class RemoveSellsToFarms < ActiveRecord::Migration[6.0]
  def change
    remove_column :farms, :sells
  end
end
