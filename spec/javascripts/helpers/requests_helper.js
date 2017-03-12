window.fake200Response = function(json) {
  return {
    status: 200,
    json: function() {
      return json;
    }
  }
};
