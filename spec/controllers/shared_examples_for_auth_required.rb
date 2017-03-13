require 'rails_helper'

# Requires at least let(:action) { :example } parameter.
# Provide let(:method) { :post } as well, when not a GET request.
#
shared_examples 'auth required' do
  let(:method) { :get }
  let(:params) { {} }
  let(:xhr) { false }
  let(:call_action) do
    send(method.to_sym, action.to_sym, params: params, xhr: xhr)
  end

  context 'when user is authenticated' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      session[:user_id] = user.id
      call_action
    end

    it 'returns 20X' do
      expect(response.status.to_s).to match(/20\d/)
    end
  end

  context 'when user is not authenticated' do
    context 'when requested using XHR' do
      let(:xhr) { true }
      before { call_action }

      it 'doesn\'t set return_to path' do
        expect(session[:return_to]).to be_nil
      end

      it 'returns 401 and error in JSON format'  do
        expect(response.status).to eq(401)

        json = ActiveSupport::JSON.decode(response.body).with_indifferent_access
        expect(json[:error]).to eq('Authentication required')
        expect(json[:location]).to eq(sign_in_url)
      end
    end

    context 'when requested without using XHR' do
      before { call_action }

      it 'sets return_to path if this is a GET request' do
        if request.get?
          expect(session[:return_to]).not_to be_nil
        else
          expect(session[:return_to]).to be_nil
        end
      end

      it 'redirects to sign_in path' do
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
