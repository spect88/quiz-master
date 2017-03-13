module AccessControl
  extend ActiveSupport::Concern

  class AccessDenied < StandardError
  end

  def deny_access!
    raise AccessDenied
  end

  def ensure_owner!(record_owner)
    deny_access! unless current_user == record_owner
  end
end
