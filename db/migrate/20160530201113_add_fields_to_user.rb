class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :position, :string
    add_column :users, :passport, :string
    add_column :users, :date_of_birth, :date
  end
end
