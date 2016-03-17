class CartsController < ApplicationController

  def show
    @cart = Cart.find(session[:cart_id])
    @line_items = @cart.line_items
    @order = Order.new
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @cart.destroy
    flash[:success] = "Корзина пустая"
    redirect_to root_path
  end

end
