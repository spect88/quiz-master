class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_current_user

  protected

  def set_current_user
    @current_user = session[:user]
  end
end
