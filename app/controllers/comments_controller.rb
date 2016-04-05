class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to :back
    else
      flash[:error] = "Не удалось добавить комментарий"
      redirect_to :back
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
    else
      flash[:alert] = "Вы можете удалить только свой комментарий"
    end
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
