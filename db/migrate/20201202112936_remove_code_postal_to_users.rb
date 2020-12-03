class RemoveCodePostalToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :code_postal, :string
  end
end
