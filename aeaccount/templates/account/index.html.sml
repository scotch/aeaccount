% extends "base.html"

% block title
  Account

% block head
  script src="http://cdnjs.cloudflare.com/ajax/libs/require.js/1.0.5/require.min.js" |
  script
    | require.config({
    |   baseUrl: "/account/static/scripts/",
    |   paths: {
    |    // uncomment this line to serve the optimized
    |    // main-build.js source file.
    |    //"main": "/account/static/scripts/main-built"
    |    "main": "/account/static/scripts/main"
    |  }
    |  });
    |  require(["plugins/order!https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js", "plugins/order!lib/angular/angular-loader", "plugins/order!main"]);

% block content
  section#content ng-controller="AccountCtrl"
    header
      h1#section-header ng-bind="partialTitle" | Account Overview

    .row
      .span2
        ul#account-nav.nav.nav-list
          li ng-class="getClass('overview')"
            a href="#/"
              i.icon-th-list |
              Overview
          li ng-class="getClass('connected')"
            a href="#/connected"
              i.icon-retweet |
              Connected Accounts
          li ng-class="getClass('password')"
            a href="#/password"
              i.icon-key |
              Password
          li ng-class="getClass('profile')"
            a href="#/profile"
              i.icon-user |
              Profile

      section#section-content
        div ng-view |