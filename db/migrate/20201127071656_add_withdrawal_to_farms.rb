class AddWithdrawalToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :withdrawal, :boolean, default: false
  end
end
