class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user, except: [:new, :create]
  before_action :list_orders, only: [:show]

  def show
    @make_admin_button = @user.admin? ? "Понизить до покупателя" : "Сделать админом"
  end

  def new
    @user = User.new
    @submit_value = "Зарегистрироваться"
  end

  def edit
    @password_placeholder = "Оставьте пустым, если не хотите изменять"
    @submit_value = "Сохранить"
  end

  def create
    @user = User.new(user_params)
    @user.role = "user"
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Спасибо за регистрацию!"
      current_user.admin? ? (redirect_to admin_path) : (redirect_to user_path(current_user))
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Ваши данные обновлены"
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
