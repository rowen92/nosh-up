class Admin::RecipesController < Admin::AdminController
  before_action :check_admin

  def edit_weight
    @recipe = Recipe.find(params[:recipe][:recipe_id])
    if @recipe.update(recipe_params)
      redirect_to :back
    end
  end

  def destroy
    @recipe.destroy
    redirect_to admin_path
  end

  private

    def recipe_params
      params.require(:recipe).permit(:weight)
    end
end
