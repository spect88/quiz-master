class Quiz < ApplicationRecord
  belongs_to :user

  def submit_answers(answers:, user:)
    # FIXME: temporary stub
    {
      correct: 1,
      incorrect: 2,
      total: 3,
      questions: [
        {
          question: 'Question one',
          answer: 'one',
          correct: true,
          expected: '1'
        },
        {
          question: 'Question two',
          answer: '22',
          correct: false,
          expected: '2'
        },
        {
          question: 'Question three',
          answer: '6',
          correct: false,
          expected: '3'
        }
      ]
    }
  end
end
