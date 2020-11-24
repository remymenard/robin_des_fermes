class AddOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|

      t.monetize :price
      t.string :status, default: "waiting"
      t.integer :transaction_id
      t.references :buyer, foreign_key: { to_table: 'users' }
      t.references :seller, foreign_key: { to_table: 'users' }

      t.timestamps
    end

  end
end
