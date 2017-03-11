require 'rails_helper'

# Requires let(:action) { get :example } parameter
shared_examples 'auth required' do
  context 'when user is authenticated' do
    before do
      user = User.create!(uid: 'auth0|456', provider: 'auth0', info: {})
      session[:user_id] = user.id
      action
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  context 'when user is not authenticated' do
    before { action }

    it 'sets return_to path' do
      expect(session[:return_to]).not_to be_nil
    end

    it 'redirects to sign_in path' do
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
