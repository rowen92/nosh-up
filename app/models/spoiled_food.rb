class SpoiledFood < ActiveRecord::Base
  belongs_to :food

  validates :food, presence: true
  validates :weight, presence: true

  self.per_page = 50

  def total_price
    weight * food.price
  end
end
