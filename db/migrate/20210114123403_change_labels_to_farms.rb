class ChangeLabelsToFarms < ActiveRecord::Migration[6.0]
  def change
    remove_column :farms, :labels, :jsonb, array: true, default: []
    add_column :farms, :labels, :text, array: true, default: []
  end
end
