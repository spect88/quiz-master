// API calls wrapper
(function() {
  'use strict';

  var QM = {};

  QM.submitAnswers = function submitAnswers(quizId, answers) {
    var path = '/quizzes/' + quizId + '/results';
    var options = preparePostRequest({ answers: answers });

    return window.fetch(path, options);
  };

  QM.getCsrfToken = function getCsrfToken() {
    return document.querySelector('meta[name=csrf-token]').content;
  };

  function preparePostRequest(payload) {
    return {
      method: 'post',
      body: JSON.stringify(payload),
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': QM.getCsrfToken()
      }
    };
  }

  window.QM = QM;
})();
