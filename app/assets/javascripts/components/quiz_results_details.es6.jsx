class QuizResultsDetails extends React.Component {
  constructor(props) {
    super(props);
    this.renderAnswerDetails = this.renderAnswerDetails.bind(this);
  }

  render() {
    const details = this.props.results.questions.map(this.renderAnswerDetails);
    return <div className="list-group">{details}</div>;
  }

  renderAnswerDetails(question, questionId) {
    const correctAnswer =
      question.correct
      ? ''
      : <p><strong>Expected answer:</strong> {question.expected}</p>;

    const resultLabel =
      question.correct
      ? this.renderLabel('success', 'correct')
      : this.renderLabel('danger', 'incorrect');

    return (
      <div className="list-group-item" key={questionId}>
        <p>{question.question}</p>
        <p><strong>Your answer:</strong> {question.answer} {resultLabel}</p>
        {correctAnswer}
      </div>
    );
  }

  renderLabel(klass, label) {
    return <span className={'label label-'+klass}>{label}</span>;
  }
}

QuizResultsDetails.propTypes = {
  results: React.PropTypes.object
};
