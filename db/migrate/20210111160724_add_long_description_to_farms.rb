class AddLongDescriptionToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :long_description, :string
  end
end
