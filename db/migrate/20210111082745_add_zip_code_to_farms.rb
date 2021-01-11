class AddZipCodeToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :zip_code, :string
  end
end
