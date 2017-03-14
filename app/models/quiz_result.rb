class QuizResult < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  def score_percentage
    # this is intentionally rounded to integers
    100 * score / max_score
  end
end
