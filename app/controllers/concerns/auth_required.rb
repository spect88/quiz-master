module AuthRequired
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  def require_authentication
    return if authenticated?
    session[:return_to] = request.path if request.get?
    redirect_to sign_in_path
  end
end
