class Admin::RecipesController < Admin::AdminController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :check_admin

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = "Рецепт добавлен"
      redirect_to [:admin, @recipe]
    else
      render :new
    end
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Рецепт обновлен"
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Рецепт удален"
    redirect_to admin_recipes_url
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:product_id, :food_id, :weight)
    end
end
