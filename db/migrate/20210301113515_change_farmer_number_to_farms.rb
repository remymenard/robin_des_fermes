class ChangeFarmerNumberToFarms < ActiveRecord::Migration[6.0]
  def change
    remove_column :farms, :farmer_number, :interger
    add_column :farms, :farmer_number, :string
  end
end
