class ChangeColumnImageUrlInProducts < ActiveRecord::Migration
  def change
    rename_column :products, :image_url, :image
  end
end
