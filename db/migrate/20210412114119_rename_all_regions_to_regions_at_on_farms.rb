class RenameAllRegionsToRegionsAtOnFarms < ActiveRecord::Migration[6.0]
  def change
    rename_column :farms, :all_regions, :regions
  end
end
