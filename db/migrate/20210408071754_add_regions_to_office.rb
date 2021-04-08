class AddRegionsToOffice < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :regions, :text, array: true, default: []
  end
end
