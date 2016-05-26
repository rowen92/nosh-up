class Product < ActiveRecord::Base
  before_destroy :ensure_not_referenced

  belongs_to :category
  has_many :line_items, dependent: :destroy
  has_many :comments
  has_many :recipes
  has_many :foods, through: :recipes

  validates :title, presence: true,
                    uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
  validates :category, presence: true

  mount_uploader :image, ProductUploader

  self.per_page = 6

  private

    def self.search(query)
      where('title ILIKE ? OR description ILIKE ?', "%#{query}%", "%#{query}%")
    end

    def self.search_for_ajax(query)
      where('title ILIKE ? OR description ILIKE ?', "%#{query}%", "%#{query}%").select(:id, :title)
    end

    def ensure_not_referenced
      if line_items.empty?
        true
      else
        errors.add(:base, "Позиция уже существует.")
        false
      end
    end
end
