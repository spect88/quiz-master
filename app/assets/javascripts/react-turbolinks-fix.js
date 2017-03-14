// This is a fix to https://github.com/reactjs/react-rails/issues/607
//
ReactRailsUJS.handleEvent('turbolinks:before-cache', function() {
  window.ReactRailsUJS.unmountComponents();
});
