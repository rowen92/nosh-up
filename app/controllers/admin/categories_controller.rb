class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :check_admin

  def index
    @categories = Category.all.order(:title)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Категория создана!"
      redirect_to ([:admin, @category])
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Категория обновлена"
      redirect_to ([:admin, @category])
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Категория удалена"
    redirect_to admin_categories_path
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title, :description, :image)
    end
end
