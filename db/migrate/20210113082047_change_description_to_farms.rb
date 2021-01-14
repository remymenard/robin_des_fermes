class ChangeDescriptionToFarms < ActiveRecord::Migration[6.0]
  def change
    change_column :farms, :description, :text
  end
end
