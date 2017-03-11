require 'rails_helper'

require_relative './shared_examples_for_auth_required'

describe DashboardController do
  it_behaves_like 'auth required' do
    let(:action) { get :show }
  end
end
