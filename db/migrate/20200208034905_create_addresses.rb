class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :event, null: false, foreign_key: true
      t.string :date,   null: false
      t.string :time,  null: false
      t.string :postcode,         null: false
      t.string :city,             null: false
      t.string :address,          null: false
      t.string :building
      t.string :phone_number
      t.timestamps
    end
  end
end
