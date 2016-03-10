class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user, except: [:new]

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Спасибо за регистрацию!'
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Ваши данные успешно обновлены.'
      redirect_to @user
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
      params.require(:user).permit(:name, :email, :phone, :role, :image_url, :password, :password_confirmation, :address)
    end
end
