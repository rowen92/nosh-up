class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:destroy, :edit, :update]
  before_action :check_admin

  def index
    if params[:role].present?
      @users = User.where(role: params[:role]).order(:name).page(params[:page])
      @user_role = @users.first.role.humanize if @users.present?
    elsif params[:staff].present?
      @users = User.where(staff: true).page(params[:page]).order(:name)
      @user_role = "Штатные сотрудники"
    else
      @users = User.page(params[:page]).order(:name)
    end
  end

  def destroy
    if @user != current_user
      @user.destroy
      flash[:success] = "Аккаунт удален"
    else
      flash[:alert] = "Ты не можешь удалить сам себя"
    end
    redirect_to :back
  rescue ActiveRecord::InvalidForeignKey
    flash[:alert] = "Аккаунт не может быть удален"
    redirect_to :back
  end

  def edit
  end

  def update
    if @user.update(user_params)
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
      params.require(:user).permit(:role, :staff)
    end

end
