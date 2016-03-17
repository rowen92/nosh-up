class OrdersController < ApplicationController

  def create
    @cart = current_cart
    @order = Order.new
    @order.add_line_items_from_cart(@cart)
    @order.status = :primary
    @order.user = current_user
    if @cart.line_items.empty?
      flash[:alert] = "Корзина пустая, для заказа выберите продукт"
      redirect_to products_path
      return
    end
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      flash[:success] = "Заказ выполнен!"
      redirect_to root_path
    else
      @cart = current_cart
      flash[:alert] = "Что-то пошло не так, сообщите в поддержку"
      redirect_to :back
    end
  end

end
