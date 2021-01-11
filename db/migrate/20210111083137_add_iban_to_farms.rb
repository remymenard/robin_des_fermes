class AddIbanToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :iban, :string
  end
end
