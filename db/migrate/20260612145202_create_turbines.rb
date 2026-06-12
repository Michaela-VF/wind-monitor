class CreateTurbines < ActiveRecord::Migration[8.1]
  def change
    create_table :turbines do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
