class ChangeAddressFieldForUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :address, :address_line_1
    add_column :users, :address_line_2, :string
  end
end
