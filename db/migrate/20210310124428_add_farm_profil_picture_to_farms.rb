class AddFarmProfilPictureToFarms < ActiveRecord::Migration[6.0]
  def change
    add_column :farms, :farm_profil_picture, :string
  end
end
