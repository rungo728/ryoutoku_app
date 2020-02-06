class CreateCooks < ActiveRecord::Migration[5.2]
  def change
    create_table :cooks do |t|
      t.references :event, null: false, foreign_key: true
      t.string :level1
      t.string :level2
      t.string :level3
      t.string :level4
      t.string :level5
      t.timestamps
    end
  end
end
