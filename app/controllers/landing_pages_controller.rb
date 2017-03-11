class LandingPagesController < ApplicationController
  def root
    redirect_to dashboard_path if authenticated?
  end
end
