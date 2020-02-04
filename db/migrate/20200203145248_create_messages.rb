class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, null: false,foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.text :content
      t.string :image
      t.timestamps
    end
  end
end
