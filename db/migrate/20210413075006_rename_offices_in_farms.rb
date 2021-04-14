class RenameOfficesInFarms < ActiveRecord::Migration[6.0]
  def change
    rename_column :farms, :offices, :old_offices
  end
end
