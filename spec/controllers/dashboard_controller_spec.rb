require 'rails_helper'

require_relative './shared_examples_for_auth_required'

describe DashboardController do
  describe 'show' do
    it_behaves_like 'auth required' do
      let(:action) { get :show }
    end

    describe 'when user is authenticated' do
      render_views

      let(:user) { FactoryGirl.create(:user) }
      let!(:quizzes) { FactoryGirl.create_list(:quiz, 3, user: user) }

      before { session[:user_id] = user.id }

      it 'renders a list of latest quizes' do
        get :show
        quizzes.each do |quiz|
          expect(response.body).to match(quiz.title)
        end
      end
    end
  end
end
