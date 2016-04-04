class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_order, only: [:show]

  def show
    @line_items = @order.line_items
  end

  def create
    @cart = current_cart
    @order = Order.new
    @order.add_line_items_from_cart(@cart)
    @order.status = :"Новый"
    @order.user = current_user
    if @cart.line_items.empty?
      flash[:alert] = "Корзина пустая, для заказа выберите продукт"
      redirect_to products_path
      return
    end
    if @order.save
      UserMailer.order_status_change(@order, @order.user).deliver_later
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

  private

    def set_order
      @order = Order.find(params[:id])
    end

end
