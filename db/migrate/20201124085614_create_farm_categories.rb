class CreateFarmCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :farm_categories do |t|
      t.references :farm, null: false, foreign_key: true
      t.references :categorie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
