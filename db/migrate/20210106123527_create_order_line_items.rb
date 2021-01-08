class CreateOrderLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_line_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
    end
  end
end
