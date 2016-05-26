class Food < ActiveRecord::Base
  has_and_belongs_to_many :products

  validates :vendor_code, uniqueness: true,
                          presence: true
  validates :title, uniqueness: true,
                    presence: true
  validates :price, presence: true
  validates :weight, presence: true
  validates :expiry_date, presence: true

  self.per_page = 50
end
