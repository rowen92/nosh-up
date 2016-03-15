class Product < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true,
                    uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
  validates :category, presence: true

  mount_uploader :image, ProductUploader
end
