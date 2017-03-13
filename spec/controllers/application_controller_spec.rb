require 'rails_helper'

describe ApplicationController do
  it do
    is_expected
      .to rescue_from(ActiveRecord::RecordNotFound)
      .with(:render_404)
  end

  it do
    is_expected
      .to rescue_from(AccessControl::AccessDenied)
      .with(:render_403)
  end
end
