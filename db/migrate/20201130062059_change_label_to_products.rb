class ChangeLabelToProducts < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :label, :text, array: true, default: [], "varchar[] USING (string_to_array(label, ';'))"
  end
end
