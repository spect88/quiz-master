require 'rails_helper'

require_relative './shared_examples_for_auth_required'

describe QuizzesController do
  describe 'show' do
    it_behaves_like 'auth required' do
      let(:action) { :show }
      let(:quiz) { FactoryGirl.create(:quiz) }
      let(:params) { { id: quiz.id } }
    end

    context 'when user is authenticated' do
      let(:user) { FactoryGirl.create(:user) }
      before { session[:user_id] = user.id }

      context 'when quiz doesn\'t exist' do
        render_views

        before { get :show, params: { id: 100 } }

        it 'returns 404 and error message' do
          expect(response.status).to eq(404)
          expect(response.body).to match(/Not found/)
        end
      end

      context 'when quiz exists' do
        render_views

        let(:quiz) { FactoryGirl.create(:quiz) }

        before { get :show, params: { id: quiz.id } }

        it 'renders quiz data' do
          expect(response.body).to match(quiz.title)
        end
      end
    end
  end
end
