class Category < ActiveRecord::Base
  has_many :products
  validates :title, presence: true,
                    uniqueness: true
  validates :description, presence: true
  validates :image_url, presence: true
end
