class LandingPagesController < ApplicationController
  def root
    redirect_to dashboard_path if authenticated?
    @custom_flash_messages_location = true
  end
end
