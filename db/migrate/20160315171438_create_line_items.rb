class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.references :product, index: true, foreign_key: true
      t.references :cart, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
