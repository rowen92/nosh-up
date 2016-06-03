class Recipe < ActiveRecord::Base
  belongs_to :product
  belongs_to :food
end
