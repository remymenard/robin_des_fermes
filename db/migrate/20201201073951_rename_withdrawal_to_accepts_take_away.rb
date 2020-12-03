class RenameWithdrawalToAcceptsTakeAway < ActiveRecord::Migration[6.0]
  def change
    rename_column :farms, :withdrawal, :accepts_take_away
  end
end
