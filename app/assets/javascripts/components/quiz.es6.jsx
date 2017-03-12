// Top-level component for Quiz mode
class Quiz extends React.Component {
  constructor(props) {
    super(props);

    this.onPreviousStep = this.onPreviousStep.bind(this);
    this.onNextStep = this.onNextStep.bind(this);
    this.onAnswerChange = this.onAnswerChange.bind(this);

    const numberOfQuestions = props.quiz.content.questions.length;

    this.state = {
      step: -1,
      answers: this.initEmptyAnswers(numberOfQuestions)
    };
  }

  render() {
    return (
      <div className="panel panel-default">
        <div className="panel-body">
          {this.renderCurrentStep()}
        </div>
      </div>
    );
  }

  renderCurrentStep() {
    if (this.state.step === -1) {
      return <QuizStart quiz={this.props.quiz} onStart={this.onNextStep} />;
    }

    if (this.state.step >= this.props.quiz.content.questions.length) {
      return <QuizEnd quiz={this.props.quiz} answers={this.state.answers} />;
    }

    return (
      <QuizQuestion
        quiz={this.props.quiz}
        questionId={this.state.step}
        answer={this.state.answers[this.state.step]}
        onPrevious={this.onPreviousStep}
        onNext={this.onNextStep}
        onAnswer={this.onAnswerChange} />
    );
  }

  onPreviousStep() {
    this.setState({ step: this.state.step - 1 });
  }

  onNextStep() {
    this.setState({ step: this.state.step + 1 });
  }

  onAnswerChange(questionId, answer) {
    const newAnswers = this.state.answers.slice(0);
    newAnswers[questionId] = answer;
    this.setState({ answers: newAnswers });
  }

  initEmptyAnswers(number) {
    const array = new Array(number);

    for (let i = 0; i < number; i++) {
      array[i] = '';
    }

    return array;
  }
}

Quiz.propTypes = {
  quiz: React.PropTypes.object
};
