class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :vendor_code
      t.string :title
      t.float :price
      t.float :weight
      t.date :expiry_date

      t.timestamps null: false
    end
  end
end
