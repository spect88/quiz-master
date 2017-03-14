// A top-level Quiz Editor component
class QuizEditor extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.initState(props.quiz);
    this.onMetadataChange = this.onMetadataChange.bind(this);
    this.onQuestionsChange = this.onQuestionsChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  render() {
    return (
      <div>
        <QuizMetadataEditor metadata={this.state.metadata} onChange={this.onMetadataChange}/>
        <QuizQuestionsEditor questions={this.state.questions} onChange={this.onQuestionsChange}/>
        <ErrorMessage error={this.state.error}/>
        <BusyIndicator loading={this.state.waiting}/>
        <div className="btn-group">
          <button
            className="btn btn-primary"
            onClick={this.onSubmit}
            disabled={this.state.waiting}>
            Save
          </button>
        </div>
      </div>
    );
  }

  onMetadataChange(metadata) {
    this.setState({ metadata });
  }

  onQuestionsChange(questions) {
    this.setState({ questions });
  }

  onSubmit(event) {
    event.preventDefault();

    const isValid = this.validateForm();
    if (!isValid) {
      this.setState({ error: 'Some of the fields are invalid' });
      return;
    }

    const newRecord = this.state.metadata.id == null;
    const attributes = this.serializeForm();

    const savedPromise =
      newRecord
      ? QM.createQuiz(attributes)
      : QM.updateQuiz(this.state.metadata.id, attributes);

    this.setState({ waiting: true, error: null });

    savedPromise
      .then((json) => {
        if (!json.location) {
          throw new Error('Invalid response');
        }
        Turbolinks.visit(json.location);
      })
      .catch((error) => {
        console.error(error);
        this.setState({ waiting: false, error: 'Unexpected error occured' });
      });
  }

  initState(quiz) {
    return {
      metadata: {
        id: quiz.id || null,
        title: quiz.title || '',
        titleError: null,
        description: richTextSerializer.deserialize(quiz.description)
      },
      questions:
        quiz.content
        ? extendQuestions(quiz.content.questions)
        : [
          {
            question: richTextSerializer.deserialize(''),
            questionError: null,
            answer: '',
            answerError: null
          }
        ],
      waiting: false,
      error: null
    };

    function extendQuestions(questions) {
      return questions.map(({ question, answer }) => {
        return {
          question: richTextSerializer.deserialize(question),
          questionError: null,
          answer,
          answerError: null
        };
      });
    }
  }

  serializeForm() {
    return {
      title: this.state.metadata.title,
      description:
        richTextSerializer.serialize(this.state.metadata.description),
      content: {
        questions: this.state.questions
          .map(({ question, answer }) => {
            return {
              question: richTextSerializer.serialize(question),
              answer
            };
          })
      }
    };
  }

  validateForm() {
    const metadata = this.validateMetadata(this.state.metadata);
    const questions = this.validateQuestions(this.state.questions);

    const isMetadataValid = metadata.titleError == null;
    const areQuestionsValid = questions.every(q => !q.questionError && !q.answerError);
    const isValid = isMetadataValid && areQuestionsValid;

    this.setState({ metadata, questions });

    return isValid;
  }

  validateMetadata({ id, title, description }) {
    return {
      id,
      title,
      titleError: (title == '') ? 'Title can\'t be blank' : null,
      description
    };
  }

  validateQuestions(questions) {
    return questions.map(({ question, answer }) => {
      const questionIsBlank = richTextSerializer.isRichTextBlank(question);

      return {
        question,
        questionError: (questionIsBlank) ? 'Question can\'t be blank' : null,
        answer,
        answerError: (answer == '') ? 'Answer can\'t be blank' : null
      }
    });
  }
}

QuizEditor.propTypes = {
  quiz: React.PropTypes.object
};
