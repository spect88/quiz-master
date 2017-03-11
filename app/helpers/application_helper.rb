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
    end
  end

  def flash_message(type, message)
    content_tag(:div, message, class: "alert #{flash_type_to_class(type)}")
  end
end
