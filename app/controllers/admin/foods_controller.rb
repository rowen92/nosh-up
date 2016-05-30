class Admin::FoodsController < Admin::AdminController
  before_action :set_food, only: [:edit, :update, :destroy]
  before_action :check_admin

  def index
    @foods = Food.all.order(updated_at: :desc)
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
      redirect_to admin_foods_url
    else
      render :new
    end
  end

  def update
    if @food.update(food_params)
      flash[:success] = "Продукт обновлен"
      redirect_to admin_foods_url
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    flash[:success] = "Продукт удален"
    redirect_to admin_foods_url
  end

  def cancel
    @food = Food.find(params[:food_id])
    SpoiledFood.create(food_id: @food.id, weight: @food.weight)
    @food.weight = 0
    @food.save
    flash[:alert] = "Продукт списан"
    redirect_to :back
  end

  private

    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:title, :price, :weight, :expiry_date)
    end
end
