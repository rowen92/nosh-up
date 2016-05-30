class Admin::SpoiledFoodsController < Admin::AdminController
  before_action :set_spoiled_food, only: [:show, :edit, :update, :destroy]

  def index
    @spoiled_foods = SpoiledFood.page(params[:page]).order(updated_at: :desc)
  end

  def show
  end

  private

    def set_spoiled_food
      @spoiled_food = SpoiledFood.find(params[:id])
    end
end
