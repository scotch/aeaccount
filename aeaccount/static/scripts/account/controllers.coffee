define [
  'jquery'
  'angular'
], (jquery, angular) ->
  'use strict'
  # App Controllers
  window.AccountCtrl = (scope, $location, $http, $watch, $resource) ->
    scope.partialTitle = "Account Overview"
    scope.$location = $location
    scope.$http = $http
    scope.$watch('$location.path()', (path) ->
        parts = path.split('/')
        scope.partialId = parts[1] || 'overview'
    )

    scope.getClass = (id) ->
      if scope.partialId is id
        return 'active'
      else
        return ''

    # TODO(kylefinley) replace this with $resource when it becomes availble
    scope.fetchUserProfiles = ->
      $http({method: 'GET', url:'/account/api/v1/user_profiles' })
        .success((data, status) ->
          scope.userProfiles = data['user_profiles']
#          scope.masterUserProfile =
        )
        .error((data, status) ->
          data = data || "Request failed"
          status = status
        )

    scope.fetchUserProfiles()

    # App Models
#    UserProfile = $resource('/user_profiles/:userProfileId',{userProfileId:'@id'})
#    userProfiles = UserProfile.query({userId:123})
#    $http({ url:'/user_profiles' })
#      .then((response) ->
#        userProfiles = response.data
#        console.log response.data
#      )
  window.AccountCtrl.$inject = ['$scope', '$location', '$http']

  window.OverviewCtrl = (scope)->
    scope.partialTitle = "Account Changed"
  window.OverviewCtrl.$inject = ['$scope', '$location', '$http']

  window.ConnectedCtrl = (scope)->
    scope.partialTitle = "Connected Accounts"
  window.ConnectedCtrl.$inject = ['$scope', '$location', '$http']

  window.PasswordCtrl = (scope)->
#    $scope.partialTitle = "Password"
  window.PasswordCtrl.$inject = ['$scope', '$location', '$http']

  window.ProfileCtrl = (scope)->
#    $scope.partialTitle = "Profile"
  window.ProfileCtrl.$inject = ['$scope', '$location', '$http']
