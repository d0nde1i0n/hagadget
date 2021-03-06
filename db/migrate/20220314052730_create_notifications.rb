class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :visitor, null: false, foreign_key: { to_table: :users }
      t.references :visited, null: false, foreign_key: { to_table: :users }
      t.references :gadget,foreign_key: true
      t.references :gadget_comment, foreign_key: true
      t.integer :action
      t.boolean :checked,default: false

      t.timestamps
    end
  end
end
