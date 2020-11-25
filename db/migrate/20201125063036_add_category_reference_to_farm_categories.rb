class AddCategoryReferenceToFarmCategories < ActiveRecord::Migration[6.0]
  def change
    remove_reference :farm_categories, :categorie, index: true, foreign_key: true
    add_reference :farm_categories, :category, null: false, foreign_key: true
  end
end
