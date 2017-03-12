require 'rails_helper'

require_relative './shared_examples_for_auth_required'
require 'support/json_schema_matcher'

describe ResultsController do
  describe 'create' do
    let(:quiz) { FactoryGirl.create(:quiz) }
    let(:attrs) do
      {
        quiz_id: quiz.id,
        answers: ['one', '22']
      }
    end

    it_behaves_like 'auth required' do
      let(:action) { :create }
      let(:method) { :post }
      let(:params) { attrs }
    end

    context 'when user is authenticated' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        session[:user_id] = user.id
        post :create, params: attrs
      end

      it 'returns 200 with correct JSON body' do
        expect(response.status).to eq(200)
        expect(response.headers['Content-Type']).to match(/application\/json/)
        expect(response).to match_response_schema(:quiz_results)
      end

      it 'returns counts of correct, inccorect and total number of questions' do
        json = ActiveSupport::JSON.decode(response.body).with_indifferent_access

        expect(json[:correct]).to be_a(Integer)
        expect(json[:incorrect]).to be_a(Integer)
        expect(json[:total]).to eq(json[:correct] + json[:incorrect])
      end
    end
  end
end
