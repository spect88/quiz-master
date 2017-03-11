class Auth0Controller < ApplicationController
  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:user] = request.env['omniauth.auth']

    # Redirect to the URL you want after successful auth
    redirect_to root_path
  end

  def failure
    flash[:error] = params[:description] || params[:key]
    Rails.logger.warn "Auth failure: #{params[:key]} (#{params[:description]})"
    redirect_to root_path
  end
end
