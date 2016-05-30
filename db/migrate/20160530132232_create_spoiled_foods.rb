class CreateSpoiledFoods < ActiveRecord::Migration
  def change
    create_table :spoiled_foods do |t|
      t.references :food, index: true, foreign_key: true
      t.float :weight

      t.timestamps null: false
    end
  end
end
