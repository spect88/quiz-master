describe('QuizEditor component', () => {
  let component, domNode;
  let quiz;

  describe('initial state', () => {
    describe('when given an empty quiz', () => {
      beforeEach(() => {
        quiz = { title: null, description: null, content: null };
        render();
      });

      it('sets up blank and valid metadata', () => {
        expect(component.state.metadata).toEqual({
          id: null,
          title: '',
          titleError: null,
          description: jasmine.any(rte.EditorValue)
        });
        expect(isBlank(component.state.metadata.description)).toBe(true);
      });

      it('sets up a single blank and valid question', () => {
        expect(component.state.questions).toEqual([
          {
            question: jasmine.any(rte.EditorValue),
            questionError: null,
            answer: '',
            answerError: null
          }
        ]);
        expect(isBlank(component.state.questions[0].question)).toBe(true);
      });
    });

    describe('when given an existing quiz', () => {
      beforeEach(() => {
        quiz = fixtures.editableQuiz();
        render();
      });

      it('aggregates metadata in a single object', () => {
        expect(component.state.metadata).toEqual({
          id: quiz.id,
          title: quiz.title,
          titleError: null,
          description: jasmine.any(rte.EditorValue)
        });
      });

      it('marks existing questions as valid', () => {
        const expected = quiz.content.questions.map(q => {
          return {
            ...q,
            question: jasmine.any(rte.EditorValue),
            questionError: null,
            answerError: null
          };
        });

        expect(component.state.questions).toEqual(expected);
      });
    });
  });

  describe('onMetadataChange', () => {
    let differentMetadata;

    beforeEach(() => {
      quiz = fixtures.editableQuiz();
      render();

      differentMetadata = {
        title: quiz.title + '!!!',
        description: rte.createEmptyValue()
      };

      component.onMetadataChange(differentMetadata);
    });

    it('updates metadata in state', () => {
      expect(component.state.metadata).toEqual(differentMetadata);
    });
  });

  describe('onQuestionsChange', () => {
    let differentMetadata;

    beforeEach(() => {
      quiz = fixtures.editableQuiz();
      render();

      differentQuestions = [];

      component.onQuestionsChange(differentQuestions);
    });

    it('updates questions in state', () => {
      expect(component.state.questions).toEqual(differentQuestions);
    });
  });

  describe('onSubmit', () => {
    let createQuizSpy, updateQuizSpy;
    let createQuizDeferred, updateQuizDeferred;

    beforeEach(() => {
      createQuizDeferred = deferred();
      updateQuizDeferred = deferred();
      createQuizSpy =
        spyOn(QM, 'createQuiz').and.returnValue(createQuizDeferred.promise);
      updateQuizSpy =
        spyOn(QM, 'updateQuiz').and.returnValue(updateQuizDeferred.promise);
    });

    it('validates metadata', () => {
      quiz = {
        title: null,
        description: null,
        content: { questions: [{ question: '1', answer: '1' }] }
      };
      render();

      expect(component.state.metadata.titleError).toBeNull();

      submit();

      expect(component.state.metadata.titleError)
        .toEqual('Title can\'t be blank');
    });

    it('validates questions', () => {
      quiz = {
        title: 'Lorem',
        description: 'Ipsum',
        content: { questions: [{ question: '', answer: '' }] }
      };
      render();

      expect(component.state.questions[0].questionError).toBeNull();

      submit();

      expect(component.state.questions).toEqual([{
        question: jasmine.any(rte.EditorValue),
        questionError: 'Question can\'t be blank',
        answer: '',
        answerError: 'Answer can\'t be blank'
      }]);
    });

    describe('when data is invalid', () => {
      beforeEach(() => {
        quiz = { title: null, description: null, content: null };
        render();
        submit();
      });

      it('doesn\'t call any APIs', () => {
        expect(createQuizSpy).not.toHaveBeenCalled();
        expect(updateQuizSpy).not.toHaveBeenCalled();
      });
    });

    describe('when data is valid', () => {
      describe('in case of new quiz', () => {
        it('calls createQuiz with data in correct format', () => {
          quiz = {
            title: 'Lorem',
            description: 'Ipsum',
            content: { questions: [{ question: 'Q', answer: 'A' }] }
          };
          render();

          submit();

          expect(createQuizSpy).toHaveBeenCalledWith(quiz);
        });
      });

      describe('in case of existing quiz', () => {
        it('calls updateQuiz with data in correct format', () => {
          quiz = {
            id: 42,
            title: 'Lorem',
            description: 'Ipsum',
            content: { questions: [{ question: 'Q', answer: 'A' }] }
          };
          render();

          submit();

          const expected = Object.assign({}, quiz);
          delete expected.id;
          expect(updateQuizSpy).toHaveBeenCalledWith(42, expected);
        });
      });
    });

    function submit() {
      component.onSubmit(jasmine.createSpyObj('event', ['preventDefault']));
    }
  });

  function render() {
    component = TestUtils.renderIntoDocument(<QuizEditor quiz={quiz}/>);
    domNode = ReactDOM.findDOMNode(component);
  }

  function isBlank(richText) {
    return richTextSerializer.isRichTextBlank(richText);
  }
});
