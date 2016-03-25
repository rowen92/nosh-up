class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :destroy]

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

  def make_admin
    @make_admin = User.find(params[:user_id])
    if @make_admin.user?
      @make_admin.update(role: "admin")
      flash[:success] = "Он теперь тоже админ!"
      redirect_to :back
    else
      @make_admin.update(role: "user")
      flash[:success] = "Понижен до уровня плебея..."
      redirect_to :back
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

end
