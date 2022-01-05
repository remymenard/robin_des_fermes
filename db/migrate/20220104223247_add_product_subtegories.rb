class AddProductSubtegories < ActiveRecord::Migration[6.0]
  def change
    create_table :product_subcategories do |t|
      t.string :name
      t.references :farm

      t.timestamps
    end

    add_reference :products, :product_subcategory, foreign_key: true
  end
end
