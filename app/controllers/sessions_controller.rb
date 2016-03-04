class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(current_user)
    else
      redirect_to :back, notise: "Invalid email or password"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
