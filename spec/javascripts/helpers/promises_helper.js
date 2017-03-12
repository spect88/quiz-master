window.deferred = function() {
  var obj = {};
  obj.promise = new Promise(function(resolve, reject) {
    obj.resolve = resolve;
    obj.reject = reject;
  });
  return obj;
};

window.nextTick = function(cb) {
  // setTimeout with 0 is not enough on phantomjs for some reason
  // (meaning the callback is still executed before promise handlers
  // we're testing)
  setTimeout(cb, 5);
};
