class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  enum status: [:"Новый", :"В обработке", :"Выполнен", :"Отменен"]

  validates :user, :status, presence: true

  self.per_page = 50

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_amount
    orders.to_a.sum { |order| order.total_price }
  end

end
