class AddCountryToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :country, :string
  end
end
