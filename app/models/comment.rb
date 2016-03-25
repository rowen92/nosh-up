class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates_presence_of :body, :user, :product
end
