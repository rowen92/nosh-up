class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.references :product, index: true, foreign_key: true
      t.references :food, index: true, foreign_key: true
      t.float :weight

      t.timestamps null: false
    end
  end
end
