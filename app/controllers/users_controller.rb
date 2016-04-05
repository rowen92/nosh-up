class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user, except: [:new, :create]
  before_action :list_orders, only: [:show]

  def show
  end

  def new
    @user = User.new
    @submit_value = "Зарегистрироваться"
  end

  def edit
    @password_placeholder = "Оставьте пустым, если не хотите изменять"
    @submit_value = "Сохранить"
    @user_class_submit = "col-xs-6"
  end

  def create
    @user = User.new(user_params)
    User.first.present? ? (@user.role = "user") : (@user.role = "admin")
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Спасибо за регистрацию!"
      current_user.admin? || current_user.manager? ? (redirect_to admin_path) : (redirect_to user_path(current_user))
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

  def list_orders
    @orders = Order.where(user: @user).order(:created_at)
  end

  private

    def set_user
      if current_user.admin? || current_user.manager?
        @user = User.find(params[:id])
      else
        @user = current_user
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone, :role, :image_url, :password, :password_confirmation, :address)
    end
end
