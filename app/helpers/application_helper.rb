module ApplicationHelper
  def current_user
    @current_user
  end

  def authenticated?
    @current_user.present?
  end
end
