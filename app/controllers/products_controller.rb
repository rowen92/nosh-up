class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @category = Category.where(id: params[:category]).first if params[:category].present?
    @products = if @category.present?
                  @category.products.page(params[:page]).order(created_at: "DESC")
                else
                  Product.page(params[:page]).order(created_at: "DESC")
                end
  end

  def show
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

end
