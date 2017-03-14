#!/usr/bin/env node
'use strict';

var BUNDLES = [
  { src: './npm_deps/index.js', dst: './vendor/assets/javascripts/npm-deps.js' },
  { src: './npm_deps/test.js', dst: './spec/javascripts/helpers/npm-test-deps.js' }
];

var fs = require('fs');
var browserify = require('browserify');
var aliasify = require('aliasify');

BUNDLES.forEach(function(bundle) {
  console.log('Bundling ' + bundle.dst + ' based on ' +  bundle.src);
  var b = browserify();
  b.add(bundle.src);
  b.bundle(function() {
    console.log('Bundled ' + bundle.dst);
  }).pipe(fs.createWriteStream(bundle.dst));
});
