class CreateGadgetComments < ActiveRecord::Migration[6.1]
  def change
    create_table :gadget_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gadget, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
