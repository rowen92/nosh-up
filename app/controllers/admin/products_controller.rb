class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :get_collect_categories, except: [:index, :show, :destroy]
  before_action :check_admin

  def index
    @category = Category.where(id: params[:category]).first if params[:category].present?
    @products = if @category.present?
                  @category.products.order(:title)
                else
                  Product.all.order(:title)
                end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Блюдо добавлено!"
      redirect_to [:admin, @product]
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Блюдо обновлено"
      redirect_to [:admin, @product]
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "Блюдо удалено"
    redirect_to admin_products_url
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :image, :category_id)
    end
end
