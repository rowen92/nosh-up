class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @category = Category.where(id: params[:category]).first if params[:category].present?
    @products = if params[:query].present?
                  Product.search(params[:query]).page(params[:page]).order(created_at: "DESC")
                else
                  if @category.present?
                    @category.products.page(params[:page]).order(created_at: "DESC")
                  else
                    Product.page(params[:page]).order(created_at: "DESC")
                  end
                end
  end

  def show
  end

  def search_suggestions
    results = if params[:query].present?
                Product.search_for_ajax(params[:query])
              else
                []
              end
    render json: results
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

end
