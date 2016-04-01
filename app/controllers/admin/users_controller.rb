class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:destroy, :edit, :update]
  before_action :check_admin

  def index
    @users = User.all.order(:name)
  end

  def destroy
    if @user != current_user
      @user.destroy
      flash[:success] = "Аккаунт удален"
    else
      flash[:alert] = "Ты не можешь удалить сам себя"
    end
    redirect_to :back
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Роль изменена"
      redirect_to :back
    else
      render :edit
    end
  end

  private

    def set_user
      if current_user.admin?
        @user = User.find(params[:id])
      else
        @user = current_user
      end
    end

    def user_params
      params.require(:user).permit(:role)
    end

end
