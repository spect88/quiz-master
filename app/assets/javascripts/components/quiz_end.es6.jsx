class QuizEnd extends React.Component {
  constructor(props) {
    super(props);
    this.state = { waiting: true, results: null, error: null };
    this.submitAnswers();
  }

  render() {
    if (this.state.waiting) {
      return <p>Submitting answers...</p>;
    }

    if (this.state.error) {
      return <div className="alert alert-danger">Error occured</div>;
    }

    return this.renderResults();
  }

  renderResults() {
    const results = this.state.results;

    const percentage = Math.round(100 * results.correct / results.total);

    return (
      <div>
        <h4>Your score: {percentage}% ({results.correct}/{results.total})</h4>
        <QuizResultsDetails results={results}/>
        <p><a href="/dashboard">Try other quizzes!</a></p>
      </div>
    );
  }

  submitAnswers() {
    const quizId = this.props.quiz.id;
    const answers = this.props.answers;

    QM.submitAnswers(quizId, answers)
      .then((response) => {
        if (response.status >= 200 && response.status < 300) {
          return response.json();
        }
        throw new Error(`HTTP Status Code: ${response.status}`);
      })
      .then((json) => {
        this.setState({ waiting: false, results: json });
      })
      .catch((error) => {
        console.error(error);
        this.setState({ waiting: false, error: error });
      });
  }
}

QuizEnd.propTypes = {
  quiz: React.PropTypes.object,
  answers: React.PropTypes.array
};
