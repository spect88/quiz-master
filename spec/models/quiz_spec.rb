require 'rails_helper'

require_relative './shared_examples_for_deletable'

describe Quiz do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(256) }
  it { is_expected.to validate_presence_of(:content) }

  it do
    is_expected
      .to allow_value(questions: [{ question: '1', answer: '2' }])
      .for(:content)
  end

  it do
    is_expected
      .not_to allow_value(questions: nil)
      .for(:content)
  end

  it_behaves_like 'deletable' do
    let(:model) { FactoryGirl.create(:quiz) }
  end

  describe '#submit_answers' do
    let(:quiz) { FactoryGirl.create(:quiz) }
    let(:user) { FactoryGirl.create(:user) }
    let(:answers) { ['twenty-six', '6'] }

    it 'returns results returned by answer checker' do
      expect_any_instance_of(AnswerChecker).to receive(:check).and_call_original
      quiz.submit_answers(answers: answers, user: user)
    end

    it 'persists the results' do
      expect { quiz.submit_answers(answers: answers, user: user) }
        .to change { QuizResult.count }
        .by(1)
      result = QuizResult.find_by(user: user, quiz: quiz)
      expect(result).not_to be_nil
    end
  end
end
