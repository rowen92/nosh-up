class CartsController < ApplicationController

  def destroy
    @cart = Cart.find(session[:cart_id])
    @cart.destroy
    flash[:success] = "Корзина пустая"
    redirect_to root_path
  end

end
