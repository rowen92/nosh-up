class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :admin_only

  def index
    @users = User.all
  end

  # Экш show может будет, а может и нет, надо еще подумать...
  # def show
  # end

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