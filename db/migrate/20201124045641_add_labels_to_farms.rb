class AddLabelsToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :labels, :jsonb, array: true, default: []
  end
end
