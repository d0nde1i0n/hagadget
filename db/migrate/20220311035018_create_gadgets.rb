class CreateGadgets < ActiveRecord::Migration[6.1]
  def change
    create_table :gadgets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :manufacture_name
      t.integer :price
      t.float :score
      t.text :description

      t.timestamps
    end
  end
end
