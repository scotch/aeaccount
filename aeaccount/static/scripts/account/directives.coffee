define [
  'jquery'
  'angular'
], (jquery, angular) ->
  'use strict'
  # http://docs-next.angularjs.org/api/angular.module.ng.$compileProvider.directive


  angular.module("myApp.directives", []).directive "appVersion", [ "version", (version) ->
    (scope, elm, attrs) ->
      elm.text version
   ]
