class CreateGadgetTags < ActiveRecord::Migration[6.1]
  def change
    create_table :gadget_tags do |t|
      t.references :gadget, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
