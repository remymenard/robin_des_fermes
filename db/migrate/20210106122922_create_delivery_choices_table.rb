class CreateDeliveryChoicesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_choices do |t|
      t.references :order, null: false, foreign_key: true
      t.references :farm, null: false, foreign_key: true
      t.boolean :takeaway_at_farm
      t.boolean :standard_shipping
      t.boolean :express_shipping
    end
  end
end
