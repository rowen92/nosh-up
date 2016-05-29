class Admin::FoodsController < Admin::AdminController
  before_action :set_food, only: [:show, :edit, :update, :destroy]
  before_action :check_admin

  def index
    @foods = Food.all.order(:title)
  end

  def show
  end

  def new
    @food = Food.new
  end

  def edit
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:success] = "Продукт добавлен"
      redirect_to [:admin, @food]
    else
      render :new
    end
  end

  def update
    if @food.update(food_params)
      flash[:success] = "Продукт обновлен"
      redirect_to [:admin, @food]
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    flash[:success] = "Продукт удален"
    redirect_to admin_foods_url
  end

  private

    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:vendor_code, :title, :price, :weight, :expiry_date)
    end
end
