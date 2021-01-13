class AddNumberPhoneToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :number_phone, :string
  end
end
