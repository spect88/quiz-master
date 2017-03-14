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
    const { quiz } = this.props;

    if (this.state.step === -1) {
      return <QuizStart quiz={quiz} onStart={this.onNextStep} />;
    }

    if (this.state.step >= this.props.quiz.content.questions.length) {
      const preparedAnswers = this.state.answers.map(a => a.answer);
      return <QuizEnd quiz={quiz} answers={preparedAnswers} />;
    }

    const question = quiz.content.questions[this.state.step];
    const answer = this.state.answers[this.state.step];

    return (
      <QuizQuestion
        question={question}
        questionId={this.state.step}
        questionsCount={quiz.content.questions.length}
        answer={answer}
        onPrevious={this.onPreviousStep}
        onNext={this.onNextStep}
        onAnswer={this.onAnswerChange} />
    );
  }

  onPreviousStep() {
    this.setState({ step: this.state.step - 1 });
  }

  onNextStep() {
    if (this.state.step >= 0) {
      // let's just validate if something has been entered
      const answer = this.state.answers[this.state.step];

      if (answer.answer == '') {
        this.onAnswerChange(this.state.step, {
          answer: '',
          answerError: 'Answer can\'t be blank'
        });
        return;
      }
    }

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
      array[i] = { answer: '', answerError: null };
    }

    return array;
  }
}

Quiz.propTypes = {
  quiz: React.PropTypes.object
};
