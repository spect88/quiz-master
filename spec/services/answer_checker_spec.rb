require 'rails_helper'

describe AnswerChecker do
  let(:quiz) { FactoryGirl.create(:quiz) }
  let(:checker) { described_class.new(quiz) }

  describe '#check' do
    let(:answers) { %w(25 5) }

    it 'sums up correct, incorrect and total numbers of questions' do
      expect(checker.check(answers)).to include(
        correct: 1,
        incorrect: 1,
        total: 2
      )
    end

    it 'returns full details' do
      q = quiz.questions.first

      expect(checker.check(answers)[:questions].first).to eq(
        question: q['question'],
        expected: q['answer'],
        answer: '25',
        correct: false
      )
    end

    context 'when given numbers as english words' do
      let(:answers) { ['twenty six', 'four'] }

      it 'correctly accepts and rejects answers' do
        results = checker.check(answers)[:questions]
        expect(results.map { |r| r[:correct] }).to eq([true, false])
      end
    end

    context 'when given answers with different letter case' do
      let(:question) do
        { question: "What's the capital of Japan?", answer: 'Tokyo' }
      end
      let(:answers) { ['toKYO'] }

      let(:quiz) do
        FactoryGirl.create(:quiz, content: { questions: [question] })
      end

      it 'still accepts the answer, ignoring letter case' do
        expect(checker.check(answers)[:correct]).to eq(1)
      end
    end
  end
end
