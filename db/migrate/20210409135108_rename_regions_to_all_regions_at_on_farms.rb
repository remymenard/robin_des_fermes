class RenameRegionsToAllRegionsAtOnFarms < ActiveRecord::Migration[6.0]
  def change
    rename_column :farms, :regions, :all_regions
  end
end
