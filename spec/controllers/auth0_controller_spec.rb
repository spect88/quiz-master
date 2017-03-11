require 'rails_helper'

describe Auth0Controller do
  describe 'callback' do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        provider: 'auth0',
        uid: 'auth0|58c03b0a61d8c359422f85ce',
        info: { name: 'John Doe', email: 'john@example.org' }
      )
    end
    let(:return_to) { nil }

    before do
      # Note that this action will not be reached if there is any OAuth error,
      # because it's being handled in middleware. The middleware sets auth hash.
      request.env['omniauth.auth'] = auth_hash
      session[:return_to] = return_to
      get :callback, params: { code: 'example', state: 'example' }
    end

    it 'saves authenticated user in session' do
      expect(session[:user_id]).not_to be_nil
      expect(User.exists?(id: session[:user_id])).to eq(true)
    end

    it 'redirects to root page' do
      expect(response).to redirect_to(root_url)
    end

    context 'when return_to path is available in session' do
      let(:return_to) { '/example' }

      it 'redirects to stored path' do
        expect(response).to redirect_to(return_to)
      end
    end
  end

  describe 'failure' do
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

  describe 'sign_in' do
    it 'redirects to OmniAuth\'s auth0 path' do
      get :sign_in
      expect(response).to redirect_to('/auth/auth0')
    end
  end

  describe 'sign_out' do
    before do
      session[:user_id] = 123
      get :sign_out
    end

    it 'sets a flash notice' do
      expect(flash[:notice]).to match(/Signed out/)
    end

    it 'removes user id from session' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to auth0 logout url' do
      expected_query_string = { returnTo: 'http://test.host/' }.to_param
      expect(response)
        .to redirect_to("https://auth0.test.com/v2/logout?#{expected_query_string}")
    end
  end
end
