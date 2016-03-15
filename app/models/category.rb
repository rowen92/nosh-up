class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  
  validates :title, presence: true,
                    uniqueness: true
  validates :description, presence: true
  validates :image_url, presence: true

  mount_uploader :image, CategoryUploader
end
