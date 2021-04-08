class CreateFarmOffices < ActiveRecord::Migration[6.0]
  def change
    create_table :farm_offices do |t|
      t.references :office, null: false, foreign_key: true
      t.references :farm, null: false, foreign_key: true
      t.integer :delivery_day
      t.integer :delivery_deadline_day
      t.time :delivery_deadline_hour

      t.timestamps
    end
  end
end
