window.fixtures = {};

window.fixtures.quiz = function() {
  return {
    id: 1,
    title: 'Test Quiz',
    description: 'Lorem ipsum dolor sit amet',
    content: {
      questions: [
        { question: 'Test Question 1' },
        { question: 'Test Question 2' },
        { question: 'Test Question 3' }
      ]
    }
  };
};

window.fixtures.quizResults = function() {
  return {
    correct: 2,
    incorrect: 1,
    total: 3,
    questions: [
      {
        question: 'Test Question 1',
        answer: 'lorem',
        correct: true,
        expected: 'Lorem'
      },
      {
        question: 'Test Question 2',
        answer: 'foo',
        correct: false,
        expected: 'bar'
      },
      {
        question: 'Test Question 3',
        answer: 'one',
        correct: true,
        expected: '1'
      }
    ]
  };
};
