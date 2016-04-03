class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    if @line_item.save
      flash[:success] = "Продукт добавлен в корзину"
      redirect_to :back
    else
      flash[:alert] = "Что-то пошло не так, сообщите нам"
      redirect_to :back
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    render json: { success: true }
  end

  def increase_quantity
    @line_item = LineItem.find(params[:line_item])
    @line_item.update_attributes(quantity: @line_item.quantity += 1)
    render json: { success: true }
  end

  def decrease_quantity
    @line_item = LineItem.find(params[:line_item])
    if @line_item.quantity == 1 || params[:delete].present?
      @line_item.destroy
    else
      @line_item.update_attributes(quantity: @line_item.quantity -= 1)
    end
    render json: { success: true }
  end

end
