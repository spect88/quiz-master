module ApplicationHelper
  def current_user
    @current_user
  end

  def authenticated?
    @current_user.present?
  end

  def flash_type_to_class(type)
    case type.to_s
    when 'error' then 'alert-danger'
    when 'notice' then 'alert-info'
    when 'success' then 'alert-success'
    end
  end

  def flash_message(type, message)
    content_tag(:div, message, class: "alert #{flash_type_to_class(type)}")
  end

  def active_controller?(name)
    params[:controller] == name.to_s
  end
end
