class AddOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|

      t.integer :price
      t.integer :transaction_id
      t.string :currency
      t.references :buyer_id, foreign_key: { to_table: 'users' }
      t.references :seller_id, foreign_key: { to_table: 'users' }

      t.timestamps
    end

  end
end
