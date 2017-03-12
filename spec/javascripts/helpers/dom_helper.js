window.selectTextContent = function(selector, node) {
  var nodesList = node.querySelectorAll(selector);
  var nodesArray = [].slice.call(nodesList, 0);
  return nodesArray
    .map(function(n) {
      return n.textContent;
    })
    .join(' $ ');
};
