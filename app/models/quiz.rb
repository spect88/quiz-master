# For some reason, I couldn't get autoloading this to work
# in rails s, rails c and rspec at the same time.
# It might be a bug in Rails 5 (note that it's not referenced by
# a constant here).
require_dependency File.expand_path(
  '../../validators/quiz_content_schema_validator', __FILE__)

class Quiz < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 256 }
  validates :content, presence: true, quiz_content_schema: true
  validates :user, presence: true

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
