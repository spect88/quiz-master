class Auth0Controller < ApplicationController
  def callback
    auth_hash = request.env['omniauth.auth']
    user = User.from_auth_hash(auth_hash)

    if user.save
      session[:user_id] = user.id
      redirect_to redirect_path_on_success
    else
      logger.error "Couldn't save user: #{auth_hash.to_h.inspect}"
      flash[:error] = "Ooops, something went wrong!"
      redirect_to root_path
    end
  end

  def failure
    flash[:error] = params[:description] || params[:key]
    logger.warn "Auth failure: #{params[:key]} (#{params[:description]})"
    redirect_to root_path
  end

  def sign_in
    redirect_to '/auth/auth0'
  end

  def sign_out
    session[:user_id] = nil
    flash[:notice] = 'Signed out'
    redirect_to auth0_logout_url
  end

  protected

  def auth0_logout_url
    base_url = Rails.application.secrets.auth0_app_endpoint
    query_params = { returnTo: root_url }.to_param
    "https://#{base_url}/v2/logout?#{query_params}"
  end

  def redirect_path_on_success
    session.delete(:return_to) || root_path
  end
end
