
section
  header
    h1#section-header
      Account
  .row
    .span2
      ul#account-nav.nav.nav-list
        li.overview.active
          a href="#/"
            i.icon-th-list |
            Overview
        li.connected
          a href="#/connected"
            i.icon-retweet |
            Connected Accounts
        li.password
          a href="#/password"
            i.icon-key |
            Password
        li.profile
          a href="#/profile"
            i.icon-user |
            Profile

    section#section-content
      {{dynamicView}}

