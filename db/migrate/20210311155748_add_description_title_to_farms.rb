class AddDescriptionTitleToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :description_title, :string
  end
end
