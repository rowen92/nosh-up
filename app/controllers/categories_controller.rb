class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all.order(:created_at)
  end

  def show
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end
end
