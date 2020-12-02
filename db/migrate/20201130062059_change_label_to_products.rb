class ChangeLabelToProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :label, :string
    add_column :products, :label, :text, array: true, default: []
  end
end
