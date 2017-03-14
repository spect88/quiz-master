# For some reason, I couldn't get autoloading this to work
# in rails s, rails c and rspec at the same time.
# It might be a bug in Rails 5 (note that it's not referenced by
# a constant here).
require_dependency File.expand_path(
  '../../validators/quiz_content_schema_validator', __FILE__)

class Quiz < ApplicationRecord
  belongs_to :user
  has_many :results, class_name: 'QuizResult', dependent: :destroy

  validates :title, presence: true, length: { maximum: 256 }
  validates :content, presence: true, quiz_content_schema: true
  validates :user, presence: true

  def submit_answers(answers:, user:)
    result = AnswerChecker.new(self).check(answers)

    # Persist this result in the database
    results.create(
      user: user,
      score: result[:correct],
      max_score: result[:total],
      details: { questions: result[:questions] }
    )

    result
  end

  def questions
    content.try(:[], 'questions')
  end

  def owned_by?(user)
    user_id == user.id
  end

  def results_of(user)
    results.where(user: user)
  end

  def taken_by?(user)
    results_of(user).exists?
  end
end
