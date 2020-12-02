class ChangeOrdersTransactionIdLimit < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :transaction_id, :integer, limit: 8
  end
end
