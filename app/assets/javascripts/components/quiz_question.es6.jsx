class QuizQuestion extends React.Component {
  constructor(props) {
    super(props);
    this.onAnswerChange = this.onAnswerChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  render() {
    const answerInputId = 'quiz_question_' + this.props.questionId;
    const questionsCount = this.props.quiz.content.questions.length;

    return (
      <div>
        <ProgressBar step={this.props.questionId + 1} outOf={questionsCount} />
        <p>{this.renderCurrentQuestion()}</p>
        <form onSubmit={this.onSubmit}>
          <div className="form-group">
            <label htmlFor={answerInputId}>Answer</label>
            <input
              type="text"
              id={answerInputId}
              className="form-control"
              value={this.props.answer}
              autoComplete="off"
              autoFocus
              onChange={this.onAnswerChange} />
          </div>
        </form>
        <div className="btn-group">
          {this.renderPreviousButton()}
          {this.renderNextButton()}
        </div>
      </div>
    );
  }

  renderCurrentQuestion() {
    return this.props.quiz.content.questions[this.props.questionId].question;
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
      (this.props.questionId < this.props.quiz.content.questions.length - 1)
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

  onAnswerChange(event) {
    const answer = event.target.value;
    this.props.onAnswer(this.props.questionId, answer);
  }

  onSubmit(event) {
    event.preventDefault();
    this.props.onNext();
  }
}

QuizQuestion.propTypes = {
  quiz: React.PropTypes.object,
  questionId: React.PropTypes.number,
  answer: React.PropTypes.string,
  onPrevious: React.PropTypes.func,
  onNext: React.PropTypes.func,
  onAnswer: React.PropTypes.func
};
