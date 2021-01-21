class AddFarmerNumberToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :farmer_number, :integer
  end
end
