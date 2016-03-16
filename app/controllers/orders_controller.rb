class OrdersController < ApplicationController

  def create
    @cart = current_cart
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.status = :new
    if @cart.line_items.empty?
      flash[:alert] = "Корзина пустая."
      redirect_to root_path
      return
    end
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      flash[:success] = "Заказ выполнен!"
      redirect_to @order
    else
      @cart = current_cart
      flash[:alert] = "Что-то пошло не так. Напишите нам."
      redirect_to :back
    end
  end

  private

    def order_params
      params.require(:order).permit(:status, :user_id)
    end
end
