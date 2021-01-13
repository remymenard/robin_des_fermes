class AddSubtitleToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :subtitle, :string
  end
end
