class Recipe < ActiveRecord::Base
  belongs_to :product
  belongs_to :food

  validates :weight, presence: true
end
