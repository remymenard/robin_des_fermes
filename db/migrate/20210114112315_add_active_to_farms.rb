class AddActiveToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :active, :boolean, default: false
  end
end
