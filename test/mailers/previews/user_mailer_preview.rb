class UserMailerPreview < ActionMailer::Preview
  def order_status_change
    UserMailer.order_status_change(Order.first, User.first)
  end
end
