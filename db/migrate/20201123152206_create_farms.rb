class CreateFarms < ActiveRecord::Migration[6.0]
  def change
    create_table :farms do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :photos
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :sells
      t.string :opening_time
      t.string :description

      t.timestamps
    end
  end
end
