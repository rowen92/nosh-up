class Admin::OrdersController < Admin::AdminController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
    @line_items = @order.line_items
  end

  def edit
  end

  def update
    if @order.update(order_params)
      flash[:success] = "Статус заказа обновлен"
      redirect_to [:admin, @order]
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    flash[:success] = "Заказ удален."
    redirect_to admin_orders_url
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status)
    end

end
