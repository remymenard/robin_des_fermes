class AddOfficesToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :offices, :text, array: true, default: []
  end
end
