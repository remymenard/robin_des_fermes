class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :farm, null: false, foreign_key: true
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.string :photo
      t.text :description
      t.text :ingredients
      t.string :label
      t.integer :unit_price

      t.timestamps
    end
  end
end
