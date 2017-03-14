// A high-level Quiz mode integration test
describe('Quiz component', () => {
  let quiz, component, domNode;

  beforeEach(() => {
    quiz = fixtures.quiz();
    component = TestUtils.renderIntoDocument(<Quiz quiz={quiz}/>);
    domNode = ReactDOM.findDOMNode(component);
  });

  describe('initially', () => {
    it('displays Quiz description', () => {
      expect(domNode.textContent).toContain(quiz.description);
    });

    it('invites the user to take the quiz', () => {
      expect(domNode.querySelector('button').textContent)
        .toEqual('Take the quiz');
    });
  });

  describe('when the quiz is in progress', () => {
    beforeEach(() => {
      // proceed to first question
      component.onNextStep();
    });

    it('displays progress', () => {
      const questionsCount = quiz.content.questions.length;
      expect(domNode.textContent).toContain(`1/${questionsCount}`);
    });

    it('displays question content', () => {
      const question = quiz.content.questions[0].question;
      expect(domNode.textContent).toContain(question);
    });

    describe('for first question', () => {
      it('allows to navigate forward only', () => {
        const buttonLabels = selectTextContent('button', domNode);
        expect(buttonLabels).toContain('Next');
        expect(buttonLabels).not.toContain('Previous');
      });
    })

    describe('for question in the middle', () => {
      beforeEach(() => {
        // type in any answer, just so that validation passes
        component.onAnswerChange(0, { answer: 'non-blank-answer' });
        // proceed to second question
        component.onNextStep();
      });

      it('allows to navigate both forward and backwards', () => {
        const buttonLabels = selectTextContent('button', domNode);
        expect(buttonLabels).toContain('Next');
        expect(buttonLabels).toContain('Previous');
      });

      describe('when answer is empty and trying to go forward', () => {
        it('displays validation error', () => {
          expect(selectTextContent('.text-danger', domNode))
            .not.toEqual('Answer can\'t be blank');
          component.onNextStep();
          expect(selectTextContent('.text-danger', domNode))
            .toEqual('Answer can\'t be blank');
        });
      });
    });

    describe('for last question', () => {
      beforeEach(() => {
        // go from first to last question (click n-1 times)
        const questionsCount = quiz.content.questions.length;
        for (let i = 0; i < questionsCount - 1; i++) {
          component.onAnswerChange(i, { answer: 'something valid' });
          component.onNextStep();
        }
      });

      it('displays a Submit button instead of Next', () => {
        const buttonLabels = selectTextContent('button', domNode);
        expect(buttonLabels).toContain('Submit');
        expect(buttonLabels).not.toContain('Next');
      });
    });
  });

  describe('when the quiz is over', () => {
    let submitAnswersSpy, submitAnswersDeferred;
    let questionsCount, expectedAnswers;

    beforeEach(() => {
      submitAnswersDeferred = deferred();
      submitAnswersSpy =
        spyOn(QM, 'submitAnswers').and.returnValue(submitAnswersDeferred.promise);

      questionsCount = quiz.content.questions.length;

      expectedAnswers = [];
      for (let i = 1; i <= questionsCount; i++) {
        expectedAnswers.push(`Answer ${i}`);
      }

      // 1 click to start + 1 click per question
      const buttonClicksNeeded = 1 + questionsCount;

      for (let i = 0; i < buttonClicksNeeded; i++) {
        component.onNextStep();

        // let's also fill in the answers
        if (i < questionsCount) {
          component.onAnswerChange(i, { answer: expectedAnswers[i] });
        }
      }
    });

    it('submits the answers', () => {
      expect(submitAnswersSpy).toHaveBeenCalledWith(quiz.id, expectedAnswers);
    });

    it('displays the results', (done) => {
      submitAnswersDeferred.resolve(fixtures.quizResults());
      nextTick(() => {
        expect(domNode.textContent).toContain('Your score: 67% (2/3)');
        done();
      });
    });
  });
});
