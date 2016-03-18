class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_cart, :set_categories

  private

    def set_categories
      @categories = Category.all.order(:title)
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authenticate_user
      unless current_user
        flash[:alert] = "Эта функция доступна только зарегистрированному пользователю!"
        redirect_to :back
      else
        true
      end
    end

    def admin_only
      unless current_user && current_user.admin?
        flash[:alert] = "Эта функция доступна только администратору!"
        redirect_to root_path
      end
    end

    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

    helper_method :current_user
end
