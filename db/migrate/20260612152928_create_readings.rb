class CreateReadings < ActiveRecord::Migration[8.1]
  def change
    create_table :readings do |t|
      t.references :turbine, null: false, foreign_key: true
      t.float :wind_speed
      t.float :power_output

      t.timestamps
    end
  end
end
