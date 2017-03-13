module AuthRequired
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  def require_authentication
    return if authenticated?

    session[:return_to] = request.path if request.get? && !request.xhr?

    if request.xhr?
      render status: 401, json: {
        error: 'Authentication required',
        location: sign_in_url
      }
    else
      redirect_to sign_in_path
    end
  end
end
