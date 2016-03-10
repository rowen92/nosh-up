class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

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

    helper_method :current_user
end
