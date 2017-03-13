class QuizQuestionEditor extends React.Component {
  constructor(props) {
    super(props);
    this.onChange = this.onChange.bind(this);
    this.onQuestionRemove = this.onQuestionRemove.bind(this);
  }

  render() {
    const id = this.props.questionId;
    const question = this.props.question;

    return (
      <div className="panel panel-default">
        <div className="panel-heading">
          {this.renderRemoveButton()}
          Question {id+1}
        </div>
        <div className="panel-body">
          <RichTextField
            label="Question"
            model={question}
            attribute="question"
            id={'question' + id}
            onChange={this.onChange}/>
          <InputField
            label="Answer"
            model={question}
            attribute="answer"
            id={'answer_' + id}
            onChange={this.onChange}/>
        </div>
      </div>
    );
  }

  renderRemoveButton() {
    if (!this.props.canBeRemoved) return '';

    return (
      <button
        className="btn btn-default btn-xs pull-right"
        onClick={this.onQuestionRemove}>
        Remove
      </button>
    );
  }

  onChange(question) {
    this.props.onChange(question, this.props.questionId);
  }

  onQuestionRemove() {
    this.props.onRemove(this.props.questionId);
  }
}

QuizQuestionEditor.propTypes = {
  question: React.PropTypes.object,
  questionId: React.PropTypes.number,
  onChange: React.PropTypes.func,
  onRemove: React.PropTypes.func
};
