class CreateAlerts < ActiveRecord::Migration[8.1]
  def change
    create_table :alerts do |t|
      t.references :turbine, null: false, foreign_key: true
      t.string :message
      t.boolean :resolved

      t.timestamps
    end
  end
end
