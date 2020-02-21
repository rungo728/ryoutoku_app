class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title,                null: false
      t.text :description,            null: false
      t.string :capacity
      t.string :place
      t.integer :price
      t.integer :exhibitor_id,        null: false, foreign_key: true
      t.integer :buyer_id,            foreign_key: true
      t.references :prefecture,       null: false, foreign_key: true
      t.references :category,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
