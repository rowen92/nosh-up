class Admin::OrdersController < Admin::AdminController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all.order(:status)
  end

  def show
    @line_items = @order.line_items
  end

  def edit
  end

  def update
    @user = @order.user
    if @order.update(order_params)
      UserMailer.order_status_change(@order, @order.user).deliver_later
      redirect_to [:admin, @order]
    else
      flash[:alert] = "Попробуйте еще раз..."
      redirect_to :back
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status)
    end

end
