class UserMailer < ApplicationMailer

  def order_status_change(order, user)
    @url = "http://www.nosh-up.com"
    @user = user
    @order = order
    mail(to: @email, subject: "Уведомление о заказе ##{@order.id} на NoshUp")
  end

end
