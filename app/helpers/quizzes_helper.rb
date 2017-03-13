module QuizzesHelper
  def render_quiz_component(quiz)
    react_component('Quiz', quiz: quiz_data_without_answers(quiz))
  end

  def quiz_data_without_answers(quiz)
    # We don't want to expose correct answers on the clientside
    quiz.as_json.tap do |hash|
      hash['content']['questions'].map! { |q| q.except('answer') }
    end
  end

  def render_quiz_editor_component(quiz)
    react_component('QuizEditor', quiz: quiz.as_json)
  end
end
