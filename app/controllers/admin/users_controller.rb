class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    flash[:success] = 'Аккаунт удален.'
    redirect_to root_path
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
