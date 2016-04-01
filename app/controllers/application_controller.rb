class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_cart, :set_categories, :line_items_count

  private

    def line_items_count
      @line_items_count = current_cart.line_items.count
    end

    def set_categories
      @categories = Category.all.order(:title)
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authenticate_user
      unless current_user
        flash[:alert] = "Эта функция доступна только зарегистрированному пользователю!"
        redirect_to new_session_path
      else
        true
      end
    end

    def check_admin
      unless current_user && current_user.admin?
        flash[:alert] = "У вас нет прав для просмотра этой страницы!"
        redirect_to :back
      end
    end

    def check_manager
      unless current_user && current_user.manager?
        flash[:alert] = "У вас нет прав для просмотра этой страницы!"
        redirect_to :back
      end
    end

    def check_admin_and_manager
      unless current_user && (current_user.manager? || current_user.admin?)
        flash[:alert] = "У вас нет прав для просмотра этой страницы!"
        redirect_to :back
      end
    end

    # Пізда, як заїбало, ААААа-аАаАаа
    # КорочЕ, освіжити голову, поїсти, а потім придумати норм алгоритм перевірки ролей
    # Подивитись вивід своїх у чужих замовлень в профілі, там якась херня твориться,а так,то наче норм, пнх воно все

    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

    helper_method :current_user
end
