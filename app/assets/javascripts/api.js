// API calls wrapper
(function() {
  'use strict';

  var QM = {};

  QM.submitAnswers = function submitAnswers(quizId, answers) {
    var path = '/quizzes/' + quizId + '/results';
    var options = prepareJsonRequest('post', { answers: answers });

    return window.fetch(path, options).then(handleStatusCodes);
  };

  QM.createQuiz = function createQuiz(attributes) {
    var path = '/quizzes';
    var options = prepareJsonRequest('post', attributes);

    return window.fetch(path, options).then(handleStatusCodes);
  };

  QM.updateQuiz = function updateQuiz(quizId, attributes) {
    var path = '/quizzes/' + quizId;
    var options = prepareJsonRequest('put', attributes);

    return window.fetch(path, options).then(handleStatusCodes);
  };

  QM.getCsrfToken = function getCsrfToken() {
    return document.querySelector('meta[name=csrf-token]').content;
  };

  function prepareJsonRequest(method, payload) {
    return {
      method: method,
      body: JSON.stringify(payload),
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': QM.getCsrfToken()
      }
    };
  }

  function handleStatusCodes(response) {
    if (response.status >= 200 && response.status < 300) {
      return response.json();
    }
    throw new Error('HTTP Status Code: ' + response.status);
  }

  window.QM = QM;
})();
