class AnswerChecker
  def initialize(quiz)
    @quiz = quiz
  end

  def check(answers)
    results = {
      correct: 0,
      incorrect: 0,
      total: @quiz.questions.size
    }

    results[:questions] =
      questions_and(answers).map do |pair|
        question, answer = pair
        expected_answer = question['answer']

        is_correct = correct_answer?(answer, expected_answer)

        if is_correct
          results[:correct] += 1
        else
          results[:incorrect] += 1
        end

        {
          question: question['question'],
          answer: answer,
          correct: is_correct,
          expected: expected_answer
        }
      end

    results
  end

  protected

  def questions_and(answers)
    @quiz.questions.zip(answers)
  end

  def correct_answer?(answer, expected)
    to_comparison_key(answer) == to_comparison_key(expected)
  end

  def to_comparison_key(text)
    return nil if text.nil?

    text
      .to_s
      .gsub(/\t\r\n-"'—–/, '')
      .squeeze(' ')
      .strip
      .gsub(/\d+/) { |number| number_as_english_words(number) }
      .upcase
  end

  def number_as_english_words(number)
    NumbersInWords.in_words(number)
  end
end
