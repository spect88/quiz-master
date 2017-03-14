class QuizStart extends React.Component {
  render () {
    return (
      <div>
        <MarkdownContent content={this.props.quiz.description}/>
        <button className="btn btn-lg btn-primary" onClick={this.props.onStart}>
          Take the quiz
        </button>
      </div>
    );
  }
}

QuizStart.propTypes = {
  quiz: React.PropTypes.object,
  onStart: React.PropTypes.func
};
