class AddPhotoPortraitToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :photo_portrait, :string
  end
end
