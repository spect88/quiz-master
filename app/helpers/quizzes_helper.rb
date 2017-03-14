module QuizzesHelper
  def render_quiz_component(quiz)
    props = { quiz: quiz_data_without_answers(quiz) }
    react_component('Quiz', props, prerender: true)
  end

  def quiz_data_without_answers(quiz)
    # We don't want to expose correct answers on the clientside
    quiz.as_json.tap do |hash|
      hash['content']['questions'].map! { |q| q.except('answer') }
    end
  end

  def render_quiz_editor_component(quiz)
    props = { quiz: quiz.as_json }
    react_component('QuizEditor', props, prerender: true)
  end
end
