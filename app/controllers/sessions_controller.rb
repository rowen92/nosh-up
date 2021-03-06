class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      current_user.admin? || current_user.manager? ? (redirect_to admin_path) : (redirect_to user_path(current_user))
    else
      flash[:error] = "Неправильный логин или пароль :("
      redirect_to :back
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
