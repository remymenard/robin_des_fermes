class AddRegionsToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :regions, :jsonb, array: true, default: []
  end
end
