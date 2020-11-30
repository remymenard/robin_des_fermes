class AddGenderToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gender, :jsonb, array: true, default: []
  end
end
