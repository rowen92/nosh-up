class Food < ActiveRecord::Base
  has_many :recipes
  has_many :products, through: :recipes
  has_many :spoiled_foods

  validates :title, uniqueness: true,
                    presence: true
  validates :price, presence: true
  validates :weight, presence: true
  validates :expiry_date, presence: true

  self.per_page = 50

  def self.search_expiry_date
    where("expiry_date < ?", Time.zone.now + 2.day).where("weight > ?", 0)
  end

  def warning?
    self.expiry_date < Time.zone.now + 2.days
  end

  def danger?
    self.expiry_date > Time.zone.now
  end
end
