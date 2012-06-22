define [
  'jquery'
  'angular'
], (jquery, angular) ->
  "use strict"
  # http://docs-next.angularjs.org/api/angular.module.ng.$filter

  angular.module("myApp.filters", []).
    filter("interpolate", ["version", (version) ->
      (text) ->
        String(text).replace(/\%VERSION\%/g, version)
    ])
