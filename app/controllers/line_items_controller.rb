class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    if @line_item.save
      flash[:success] = "Позиция добавлена!"
      redirect_to cart_path
    else
      flash[:danger] = "Сообщите нам, что-то пошло не так."
      redirect_to :back
    end
  end

  def increase_quantity
    @line_item = LineItem.find(params[:line_item])
    @line_item.update_attributes(quantity: @line_item.quantity += 1)
    redirect_to :back
  end

  def decrease
    @line_item = LineItem.find(params[:line_item])
    if @line_item == 1 || params(:delete).present?
      @line_item.destroy
    else
      @line_item.update_attributes(quantity: @line_item.quantity -= 1)
    end
    redirect_to :back
  end

end
