class AddCityToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :city, :string
  end
end
