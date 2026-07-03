class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_path
  end

  def correct_user
    @user = User.find(params[:id])
    return if current_user?(@user)

    flash[:danger] = "You are not authorized to perform this action."
    redirect_to root_path
  end

  def correct_micropost
    @micropost = Micropost.find(params[:id])
    return if @micropost.user == current_user

    flash[:danger] = "You are not authorized to perform this action."
    redirect_to root_path
  end
end
