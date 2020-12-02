class ChangeRegionsToFarms < ActiveRecord::Migration[6.0]
  def change
    change_column :farms, :regions, :text, array: true, default: []
  end
end
