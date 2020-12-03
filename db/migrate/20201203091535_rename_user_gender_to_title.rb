class RenameUserGenderToTitle < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :gender, :title
  end
end
