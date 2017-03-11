require 'rails_helper'

describe Auth0Controller do
  describe '/auth/auth0/callback' do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        provider: 'auth0',
        uid: 'auth0|58c02b0a61d8c359422f85ce',
        info: { name: 'John Doe', email: 'john@example.org' }
      )
    end

    before do
      # Note that this action will not be reached if there is any OAuth error,
      # because it's being handled in middleware. The middleware sets auth hash.
      request.env['omniauth.auth'] = auth_hash
      get :callback, params: { code: 'example', state: 'example' }
    end

    it 'redirects to root page' do
      expect(response).to redirect_to(root_url)
    end

    it 'saves authenticated user in session' do
      expect(session[:user]).not_to be_nil
    end
  end

  describe '/auth/failure' do
    let(:error_key) { 'example_msg' }
    let(:error_description) { 'Error occured' }

    before do
      get :failure, params: { key: error_key, description: error_description }
    end

    it 'sets a flash error message' do
      expect(flash[:error]).to eq(error_description)
    end

    it 'redirects to root page' do
      expect(response).to redirect_to(root_url)
    end
  end
end
