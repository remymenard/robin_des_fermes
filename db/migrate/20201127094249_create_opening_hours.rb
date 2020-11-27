class CreateOpeningHours < ActiveRecord::Migration[6.0]
  def change
    create_table :opening_hours do |t|
      t.references :farm, null: false, foreign_key: true
      t.integer :day
      t.time :closes
      t.time :opens

      t.timestamps
    end
  end
end
