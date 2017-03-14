class QuizQuestion extends React.Component {
  constructor(props) {
    super(props);
    this.onAnswerChange = this.onAnswerChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  render() {
    const { questionId, question, answer, questionsCount } = this.props;
    const answerInputId = 'quiz_question_' + questionId;

    return (
      <div>
        <ProgressBar step={questionId + 1} outOf={questionsCount} />
        <MarkdownContent content={question.question} />
        <form onSubmit={this.onSubmit}>
          <InputField
            id={answerInputId}
            model={answer}
            attribute="answer"
            label="Answer"
            onChange={this.onAnswerChange} />
        </form>
        <div className="btn-group">
          {this.renderPreviousButton()}
          {this.renderNextButton()}
        </div>
      </div>
    );
  }

  renderPreviousButton() {
    if (this.props.questionId === 0) return '';

    return (
      <button
        className="btn btn-default"
        onClick={this.props.onPrevious}>
        Previous
      </button>
    );
  }

  renderNextButton() {
    const label =
      (this.props.questionId < this.props.questionsCount - 1)
      ? 'Next'
      : 'Submit';

    return (
      <button
        className="btn btn-primary"
        onClick={this.props.onNext}>
        {label}
      </button>
    );
  }

  onAnswerChange(answerModel) {
    this.props.onAnswer(this.props.questionId, answerModel);
  }

  onSubmit(event) {
    event.preventDefault();
    this.props.onNext();
  }
}

QuizQuestion.propTypes = {
  question: React.PropTypes.object,
  questionId: React.PropTypes.number,
  questionsCount: React.PropTypes.number,
  answer: React.PropTypes.object,
  onPrevious: React.PropTypes.func,
  onNext: React.PropTypes.func,
  onAnswer: React.PropTypes.func
};
