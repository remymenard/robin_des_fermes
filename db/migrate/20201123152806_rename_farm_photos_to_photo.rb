class RenameFarmPhotosToPhoto < ActiveRecord::Migration[6.0]
  def change
    rename_column :farms, :photos, :photo
  end
end
