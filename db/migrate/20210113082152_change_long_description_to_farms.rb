class ChangeLongDescriptionToFarms < ActiveRecord::Migration[6.0]
  def change
    change_column :farms, :long_description, :text
  end
end
