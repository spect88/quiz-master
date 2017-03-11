class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  protected

  def set_current_user
    return if session[:user_id].nil?
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticated?
    @current_user.present?
  end
end
