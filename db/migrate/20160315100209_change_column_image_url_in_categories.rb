class ChangeColumnImageUrlInCategories < ActiveRecord::Migration
  def change
    rename_column :categories, :image_url, :image
  end
end
