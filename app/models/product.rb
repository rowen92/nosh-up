class Product < ActiveRecord::Base
  before_destroy :ensure_not_referenced

  belongs_to :category
  has_many :line_items, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
  validates :category, presence: true

  mount_uploader :image, ProductUploader

  private

    def ensure_not_referenced
      if line_items.empty?
        true
      else
        errors.add(:base, "Позиция уже существует.")
        false
      end
    end
end