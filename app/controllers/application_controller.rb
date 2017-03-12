class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected

  def set_current_user
    return if session[:user_id].nil?
    @current_user = User.find_by(id: session[:user_id])
  end

  attr_reader :current_user

  def authenticated?
    @current_user.present?
  end

  def render_404(_error)
    render template: 'errors/404', status: 404
  end

  def render_500(error)
    logger.error "Uncaught error: #{error.to_s}\n#{error.backtrace.join("\n")}"
    render template: 'errors/500', status: 500
  end
end
