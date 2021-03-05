class AddSlugToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :slug, :string
    add_index :farms, :slug, unique: true
  end
end
