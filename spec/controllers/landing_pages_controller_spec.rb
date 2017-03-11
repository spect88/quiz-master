require 'rails_helper'

describe LandingPagesController do
  render_views

  describe 'root' do
    context 'when user is not authenticated' do
      before { get :root }

      it 'displays root landing page' do
        expect(response.body).to match(/Quiz Master/)
        expect(response.body).to match(/Get started/)
      end
    end

    context 'when user is authenticated' do
      before do
        user = FactoryGirl.create(:user)
        session[:user_id] = user.id
        get :root
      end

      it 'redirects to dashboard' do
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
