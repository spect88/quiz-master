class QuizQuestionsEditor extends React.Component {
  constructor(props) {
    super(props);
    this.renderQuestionEditor = this.renderQuestionEditor.bind(this);
    this.onQuestionAdd = this.onQuestionAdd.bind(this);
    this.onQuestionChange = this.onQuestionChange.bind(this);
    this.onQuestionRemove = this.onQuestionRemove.bind(this);
  }

  render() {
    const questions = this.props.questions || [];

    return (
      <div>
        <h4>Questions</h4>
        {questions.map(this.renderQuestionEditor)}
        <div className="form-group">
          <button className="btn btn-default" onClick={this.onQuestionAdd}>
            Add question
          </button>
        </div>
      </div>
    );
  }

  renderQuestionEditor(question, questionId) {
    const questionsCount = this.props.questions.length;
    const canBeRemoved = questionsCount > 1;

    return (
      <QuizQuestionEditor
        question={question}
        canBeRemoved={canBeRemoved}
        onChange={this.onQuestionChange}
        onRemove={this.onQuestionRemove}
        questionId={questionId}
        key={questionId} />
    );
  }

  onQuestionAdd() {
    // create a copy of questions array and append a blank question
    const questions = this.props.questions.slice(0);
    questions.push({
      question: rte.createEmptyValue(),
      questionError: null,
      answer: '',
      answerError: null
    });

    this.props.onChange(questions);
  }

  onQuestionChange(question, questionId) {
    // create a copy of questions array and replace question
    const questions = this.props.questions.slice(0);
    questions.splice(questionId, 1, question);

    this.props.onChange(questions);
  }

  onQuestionRemove(questionId) {
    // create a copy of questions array and remove question
    const questions = this.props.questions.slice(0);
    questions.splice(questionId, 1);

    this.props.onChange(questions);
  }
}

QuizQuestionsEditor.propTypes = {
  questions: React.PropTypes.array,
  onChange: React.PropTypes.func
};
