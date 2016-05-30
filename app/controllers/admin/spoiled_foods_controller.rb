class Admin::SpoiledFoodsController < Admin::AdminController
  before_action :set_spoiled_food, only: [:show, :edit, :update, :destroy]

  def index
    @spoiled_foods = SpoiledFood.all
  end

  def show
  end

  def new
    @spoiled_food = SpoiledFood.new
  end

  def edit
  end

  def create
    @spoiled_food = SpoiledFood.new(spoiled_food_params)
    if @spoiled_food.save
      redirect_to [:admin, @spoiled_food]
    else
      render :new
    end
  end

  def update
      if @spoiled_food.update(spoiled_food_params)
        redirect_to @spoiled_food, notice: 'Spoiled food was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @spoiled_food.destroy
    redirect_to admin_spoiled_foods_url, notice: 'Spoiled food was successfully destroyed.'
  end

  private

    def set_spoiled_food
      @spoiled_food = SpoiledFood.find(params[:id])
    end

    def spoiled_food_params
      params.fetch(:spoiled_food, {})
    end
end
