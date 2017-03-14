module DashboardHelper
  def quiz_list_item_class(quiz)
    result = quiz.results_of(current_user).first

    case
    when quiz.owned_by?(current_user)
      'list-group-item list-group-item-info'
    when result.nil?
      'list-group-item'
    when result.score_percentage > 80
      'list-group-item list-group-item-success'
    when result.score_percentage < 50
      'list-group-item list-group-item-danger'
    else
      'list-group-item list-group-item-warning'
    end
  end
end
