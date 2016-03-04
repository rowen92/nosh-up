class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.integer :role
      t.string :image_url
      t.string :password_digest
      t.string :address

      t.timestamps null: false
    end
  end
end
