class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :admin_only

  def index
    @categories = Category.all
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
      flash[:success] = 'Категория успешно создана!'
      redirect_to ([:admin, @category])
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Категория успешно обновлена.'
      redirect_to ([:admin, @category])
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'Категория успешно удалена.'
    redirect_to categories_url
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title, :description, :image_url)
    end
end
