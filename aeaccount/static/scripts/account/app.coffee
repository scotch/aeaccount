define [
  # jQuery
  'jquery'
  # Angular
  'angular'
  # App
  'cs!account/filters'
  'cs!account/services'
  'cs!account/directives'
  'cs!account/controllers'
], (jquery, angular, f, s, d, c) ->
  "use strict"
  # Declare app level module which depends on filters, and services
  angular.module("myApp", [ "myApp.filters", "myApp.services", "myApp.directives" ]).
    config([ "$routeProvider", ($routeProvider) ->
      $routeProvider.when('/overview', {template: 'static/scripts/account/partials/overview.html', controller: OverviewCtrl})
      $routeProvider.when('/connected', {template: 'static/scripts/account/partials/connected.html', controller: ConnectedCtrl})
      $routeProvider.when('/password', {template: 'static/scripts/account/partials/password.html', controller: PasswordCtrl})
      $routeProvider.when('/profile', {template: 'static/scripts/account/partials/profile.html', controller: ProfileCtrl})
      $routeProvider.otherwise({redirectTo: '/overview'})
    ])
