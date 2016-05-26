class CreateProductsFoodsJoin < ActiveRecord::Migration
  def change
    create_table :products_foods, id: false do |t|
      t.integer :product_id
      t.integer :food_id
    end
  end
end
