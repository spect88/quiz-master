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

  describe 'new' do
    it_behaves_like 'auth required' do
      let(:action) { :new }
    end

    context 'when user is authenticated' do
      render_views

      let(:user) { FactoryGirl.create(:user) }
      before do
        session[:user_id] = user.id
        get :new
      end

      it 'renders a new quiz form' do
        expect(response.status).to eq(200)
        expect(response.body).to match('<h2>New Quiz</h2>')
      end
    end
  end

  describe 'edit' do
    let(:user) { FactoryGirl.create(:user) }
    let(:quiz) { FactoryGirl.create(:quiz, user: user) }

    it_behaves_like 'auth required' do
      let(:action) { :edit }
      let(:params) { { id: quiz.id } }
    end

    context 'when user is authenticated' do
      render_views

      before { session[:user_id] = user.id }

      context 'when user owns given quiz' do
        before { get :edit, params: { id: quiz.id } }

        it 'returns 200' do
          expect(response.status).to eq(200)
        end

        it 'renders an edit quiz form' do
          expect(response.body).to match('<h2>Edit Quiz</h2>')
        end
      end

      context 'when user doesn\'t own given quiz' do
        let(:someone_elses_quiz) { FactoryGirl.create(:quiz) }
        before { get :edit, params: { id: someone_elses_quiz.id } }

        it 'doesn\'t render usual edit quiz form' do
          expect(response.body).not_to match('<h2>Edit Quiz</h2>')
        end

        it 'returns 403' do
          expect(response.status).to eq(403)
        end

        it 'renders an error page' do
          expect(response.body).not_to match('Something went wrong')
        end
      end
    end
  end

  describe 'create' do
    let(:attrs) { FactoryGirl.attributes_for(:quiz) }

    it_behaves_like 'auth required' do
      let(:action) { :create }
      let(:method) { :post }
      let(:params) { attrs }
    end

    context 'when user is authenticated' do
      let(:user) { FactoryGirl.create(:user) }
      before { session[:user_id] = user.id }

      context 'when attributes are valid' do
        it 'creates the Quiz' do
          expect { post :create, params: attrs }.to change(Quiz, :count).by(1)
        end

        it 'returns 201' do
          post :create, params: attrs
          expect(response.status).to eq(201)
        end

        it 'sets flash notice' do
          post :create, params: attrs
          expect(flash[:notice]).not_to be_nil
        end

        it 'returns the url of new quiz' do
          post :create, params: attrs
          expect(response).to match_response_schema(:quiz_saved)
        end
      end
    end
  end

  describe 'update' do
    let(:user) { FactoryGirl.create(:user) }
    let(:quiz) { FactoryGirl.create(:quiz, user: user) }
    let(:attrs) { FactoryGirl.attributes_for(:quiz) }

    it_behaves_like 'auth required' do
      let(:action) { :update }
      let(:method) { :put }
      let(:params) { attrs.merge(id: quiz.id) }
    end

    context 'when user is authenticated' do
      before { session[:user_id] = user.id }

      context 'when updating their own quiz' do
        it 'returns 200' do
          put :update, params: attrs.merge(id: quiz.id)
          expect(response.status).to eq(200)
        end

        it 'updates the Quiz' do
          expect { put :update, params: attrs.merge(id: quiz.id) }
            .to change { quiz.reload.title }
        end

        it 'returns JSON with quiz URL' do
          put :update, params: attrs.merge(id: quiz.id)
          expect(response).to match_response_schema(:quiz_saved)
        end

        context 'when some attributes are invalid' do
          let(:attrs) do
            { title: '', description: 'Ipsum' }
          end
          before { put :update, params: attrs.merge(id: quiz.id) }

          it 'returns 400' do
            expect(response.status).to eq(400)
          end

          it 'returns JSON with error messages' do
            expect(response).to match_response_schema(:short_validation_errors)
          end
        end
      end

      context 'when updating someone else\'s quiz' do
        let(:someone_elses_quiz) { FactoryGirl.create(:quiz) }
        before do
          put :update, params: attrs.merge(id: someone_elses_quiz.id)
        end

        it 'returns 403' do
          expect(response.status).to eq(403)
        end
      end
    end
  end
end
